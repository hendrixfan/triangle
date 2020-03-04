lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "triangle_pattern/version"

Gem::Specification.new do |spec|
  spec.name          = "triangle_pattern"
  spec.version       = TrianglePattern::VERSION
  spec.authors       = ["Wolfgang Wohanka"]
  spec.email         = ["wolfgang.wohanka@pludoni.de"]

  spec.summary       = "Background pattern generator using Delaunay Triangulation"
  spec.description   = "Background pattern generator using Delaunay Triangulation"
  spec.homepage      = "https://github.com/hendrixfan/triangle"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hendrixfan/triangle"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 2.0"

  spec.add_dependency 'delaunator', '~> 0.1.1'
  spec.add_dependency 'gradient'
end
