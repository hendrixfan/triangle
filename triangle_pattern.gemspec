# frozen_string_literal: true

require_relative 'lib/triangle_pattern/version'

Gem::Specification.new do |spec|
  spec.name          = 'triangle_pattern'
  spec.version       = TrianglePattern::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ['Wolfgang Wohanka']
  spec.email         = ['wolfgang.wohanka@pludoni.de']

  spec.summary       = 'Background pattern generator using Delaunay Triangulation'
  spec.description   = 'Background pattern generator using Delaunay Triangulation'
  spec.homepage      = 'https://github.com/hendrixfan/triangle'
  spec.license       = 'MIT'

  spec.metadata = {
    'yard.run'          => 'yard',
    'bug_tracker_uri'   => 'https://github.com/hendrixfan/triangle/issues',
    'documentation_uri' => 'https://www.rubydoc.info/gems/triangle_pattern',
    'homepage_uri'      => spec.homepage
    'source_code_uri'   => 'https://github.com/hendrixfan/triangle'
  }

  spec.files         = Dir['bin/*'] + Dir['fixtures/*.svg'] + Dir['lib/**/*.rb']
  spec.files        += ['LICENSE.txt']
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.4'

  spec.add_development_dependency 'bundler', '~> 2.0'

  spec.add_dependency 'delaunator', '~> 0.1.1'
  spec.add_dependency 'gradient', '~> 0.5.1'
end
