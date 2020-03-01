require 'triangle'
require 'triangle/rake_task'

module Triangle
  class TriangleTask < RakeTask
    attr_reader :data

    attr_reader :allowed_patterns

    def initialize(opts = {})
      super

      raise ArgumentError, :data if @options[:data].nil?

      @data             = @options[:data]
    end

    def run_task(_verbose)
      data.each do |path, string|
        opts = {}
        path = File.expand_path(path)

        if string.is_a?(Hash)
          opts[:colors]   = string[:colors] if string.key? :colors
          opts[:width]      = string[:width] if string.key? :width
          opts[:height] = string[:height] if string.key? :height
          opts[:cell_size] = string[:cell_size] if string.key? :cell_size
          opts[:seed] = string[:seed] if string.key? :seed
          opts[:variance] = string[:variance] if string.key? :variance
        else
          raise 'Invalid data structure for Rake Task'
        end

        pattern = Triangle.generate(opts)

        logger.info "Creating pattern at \"#{path}\"."
        FileUtils.mkdir_p File.dirname(path)
        File.write(path, pattern.to_svg)
      end
    end
  end
end
