require 'base64'
require 'triangle_pattern/version'
require 'triangle_pattern/pattern'
require 'triangle_pattern/grid'
require 'triangle_pattern/svg_image'
require 'delaunator/triangulator'
require 'gradient'

module TrianglePattern
  def self.generate(width: 900, height: 500, cell_size: 75, variance: 0.75, seed: 135, colors: ["#ffffe5","#f7fcb9","#d9f0a3","#addd8e","#78c679","#41ab5d","#238443","#006837","#004529"])
    TrianglePattern::Pattern.new(width, height, cell_size, variance, seed, colors)
  end
end
