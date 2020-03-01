require 'rake'
require 'rake/tasklib'
require 'logger'

module Triangle
  class RakeTask < ::Rake::TaskLib
    include ::Rake::DSL if defined?(::Rake::DSL)

    attr_reader :name

    attr_reader :description

    attr_reader :verbose

    private

    attr_reader :task_arguments, :task_block, :logger, :working_directory

    def initialize(opts = {}, &task_block)
      @options = {
        description: nil,
        name: self.class.to_s.split(/::/).slice(-2..-1).join(':').gsub(/Task$/, ''),
        arguments: [],
        logger: ::Logger.new($stderr),
        working_directory: Dir.getwd
      }.merge opts

      before_initialize

      raise ArgumentError, :description if @options[:description].nil?

      @description       = @options[:description]
      @task_arguments    = Array(@options[:arguments])
      @task_block        = task_block
      @logger            = @options[:logger]
      @working_directory = @options[:working_directory]
      @name              = @options[:name]

      after_initialize

      define_task
    end

    def after_initialize; end

    def before_initialize; end

    def define_task
      desc description unless ::Rake.application.last_comment

      task name, *task_arguments do |_, task_args|
        RakeFileUtils.__send__(:verbose, verbose) do
          instance_exec(*[self, task_args].slice(0, task_block.arity), &task_block) if task_block.respond_to? :call
          run_task verbose
        end
      end
    end

    def run_task(_verbose); end

    public

    def instance_binding
      binding
    end

    # Include module in instance
    def include(modules)
      modules = Array(modules)

      modules.each { |m| self.class.include m }
    end
  end
end
