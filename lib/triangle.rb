require 'base64'
require 'triangle/version'
require 'triangle/surface_triangulation'
require 'triangle/grid'
require 'triangle/svg_image'
require 'delaunator/triangulator'
require 'gradient'

module Triangle
  def self.generate(width: 900, height: 500, cell_size: 75, variance: 0.75, seed: 135, colors: ["#ffffe5","#f7fcb9","#d9f0a3","#addd8e","#78c679","#41ab5d","#238443","#006837","#004529"])
    triangle_pattern = Triangle::SurfaceTriangulation.new(width, height, cell_size, variance, seed, colors)
  end
end
