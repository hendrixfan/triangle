require 'triangle/version'
require 'triangle/surface_triangulation'
require 'victor'
require 'delaunator/triangulator'
require 'gradient'

module Triangle
  def self.triangulate_surface(width: 900, height: 800, cell_size: 75, variance: 0.75, seed: 135, colors: ["#ffffe5","#f7fcb9","#d9f0a3","#addd8e","#78c679","#41ab5d","#238443","#006837","#004529"])
    cells_x = ((width + 4 * cell_size) / cell_size).floor
    cells_y = ((height + 4 * cell_size) / cell_size).floor
    bleed_x = ((cells_x * cell_size) - width) / 2
    bleed_y = ((cells_y * cell_size) - height) / 2

    calc_variance = cell_size * variance / 2.to_f
    points = generate_points(width, height, bleed_x, bleed_y, cell_size, calc_variance, seed)
    d = Delaunator::Triangulator.new(points.flatten)
    d.triangulate
    delauny_indicies = d.triangles
    Triangle::SurfaceTriangulation.new(width, height, delauny_indicies, points, colors).build_svg
  end


  def self.generate_points(width, height, bleed_x, bleed_y, cell_size, variance, seed)
    half_cell_size = (cell_size / 2.to_f).round
    double_v = variance * 2
    negative_v = -variance
    points = []
    prng1 = Random.new(seed)
    h = height + bleed_y
    w = width + bleed_x
    i = -bleed_x
    j = -bleed_y
    (-bleed_x..w-bleed_x).step(cell_size) do |i|
      (-bleed_y..h-bleed_x).step(cell_size) do |j|
        x = (i + half_cell_size) + (prng1.rand * double_v + negative_v)
        y = (j + half_cell_size) + (prng1.rand * double_v + negative_v)
        points << [x.floor, y.floor]
      end
    end
    points
  end
end
