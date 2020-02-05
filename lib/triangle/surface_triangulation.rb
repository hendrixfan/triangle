module Triangle
  class SurfaceTriangulation
    # Parameter: Cell-Größe in %
                # Variance in %
                # Seed Zahl ziwchen 0-200
                # Farbpalette 5 Farben
    def initialize(width, height, delauny_indicies, points)
      @width = width
      @height = height
      @delauny_indicies = delauny_indicies
      @points = points
    end

    def generate_triangles
      triangles = []
      triangle_count = @delauny_indicies.length / 3
      start = "62fc03"
      stop = "4103fc"
      g = Triangle::Gradient.new(start, stop, triangle_count)

      color_index = 0
      (0..@delauny_indicies.length-1).step(3) do |i|
        vertices = [@points[@delauny_indicies[i]], @points[@delauny_indicies[i + 1]], @points[@delauny_indicies[i + 2]]]
        centroid = centroid(vertices)
        x_col = g.gradient((norm('x', centroid[:x]) * triangle_count).round)
        y_col = g.gradient((norm('y', centroid[:y]) * triangle_count).round)
        t_col = Triangle::Gradient.new(x_col, y_col, triangle_count)
        triangle_color = "##{t_col.gradient(color_index)}"
        triangles << [triangle_color, vertices]
        color_index += 1
      end
      triangles
    end

    def build_svg
      triangles = generate_triangles
      svg = Victor::SVG.new width: 800, height: 500, style: { background: '#ddd' }
      style = {
        stroke: 'yellow',
        stroke_width: 3
      }
      svg.build do
        triangles.each do |triangle|
          polygon = triangle[1].flatten.insert(0, "M").insert(3, "L").insert(6, "L").insert(-1, "Z")
          path d: polygon, stroke: triangle[0], fill: triangle[0]
        end

      end
      svg.save 'points'
    end

    private

    def centroid(d)
      return {
        x: ((d[0][0] + d[1][0] + d[2][0])/3.to_f).round,
        y: ((d[0][1] + d[1][1] + d[2][1])/3.to_f).round
      }
    end

    def norm(axis, value)
      dimension = axis == 'x' ? @width : @height
      return clamp(
        _map(value, [0, dimension], [0, 1]),
        [0, 1]
      )
    end

    def _map(num, in_range, out_range)
      (num - in_range[0] ) * ( out_range[1] - out_range[0] ) / (( in_range[1] - in_range[0] ) + out_range[0]).to_f
    end

    def clamp (num, interval)
      [[num, interval[0]].max, interval[1]].min
    end
  end
end
