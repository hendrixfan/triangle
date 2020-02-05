require 'triangle/version'
require 'triangle/surface_triangulation'
require 'triangle/gradient'
require 'victor'
require 'delaunator'

module Triangle
  def self.triangulate_surface(width: 600, height: 400, cell_size: 75, variance: 0.75, seed: 135)
    cells_x = ((width + 4 * cell_size) / cell_size).floor
    cells_y = ((height + 4 * cell_size) / cell_size).floor
    bleed_x = ((cells_x * cell_size) - width) / 2
    bleed_y = ((cells_y * cell_size) - height) / 2

    calc_variance = cell_size * variance / 2.to_f
    points = generate_points(width, height, cell_size, calc_variance, seed)
    delauny_indicies = Delaunator.triangulate(points)
    Triangle::SurfaceTriangulation.new(width, height, delauny_indicies, points).build_svg
  end


  def self.generate_points(width, height, cell_size, variance, seed)
    half_cell_size = (cell_size / 2.to_f).round
    double_v = variance * 2
    negative_v = -variance
    points = []
    prng1 = Random.new(seed)
    (0..width).step(cell_size) do |i|
      (0..height).step(cell_size) do |j|
        x = (i + half_cell_size) + (prng1.rand * double_v + negative_v)
        y = (j + half_cell_size) + (prng1.rand * double_v + negative_v)
        points << [x.floor, y.floor]
      end
    end
    points
  end
end
