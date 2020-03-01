require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

unless ENV.key?('CI')
  require 'triangle/triangle_task'

  namespace :fixtures do
    Triangle::TriangleTask.new(
      name: 'generate', description: '', data: {
        'fixtures/BuGn.svg' => { colors: ["#edf8fb", "#b2e2e2", "#66c2a4", "#2ca25f", "#006d2c"] },
        'fixtures/GnBu.svg' => { colors: ["#edf8fb", "#b3cde3", "#8c96c6", "#8856a7", "#810f7c"] },
        'fixtures/OrRd.svg' => { colors: ["#fef0d9", "#fdcc8a", "#fc8d59", "#e34a33", "#b30000"] },
        'fixtures/BrBG.svg' => { colors: ["#a6611a", "#dfc27d", "#f5f5f5", "#80cdc1", "#018571"] },
      }
    )
  end
end
