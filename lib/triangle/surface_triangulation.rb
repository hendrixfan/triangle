module Triangle
  class SurfaceTriangulation
    def initialize(width, height, cell_size, variance, seed, colors, svg = Triangle::SvgImage.new)
      @svg    = svg
      @width = width
      @height = height
      @points = Triangle::Grid.new(@width, @height, cell_size, variance, seed).generate_grid
      d = Delaunator::Triangulator.new(@points.flatten)
      d.triangulate
      @delauny_indicies = d.triangles
      @colors = colors
      @triangles = generate_triangles
    end

    def to_svg
      image.to_s
    end

    def to_base64
      Base64.strict_encode64(to_svg)
    end

    private

    def generate_triangles
      triangles = []
      triangle_count = @delauny_indicies.length / 3
      gradient_map = build_color_gradient
      color_index = 0
      (0..@delauny_indicies.length-1).step(3) do |i|
        vertices = [@points[@delauny_indicies[i]], @points[@delauny_indicies[i + 1]], @points[@delauny_indicies[i + 2]]]
        centroid = centroid(vertices)
        x_col = gradient_map.at(norm('x', centroid[:x]))
        y_col = gradient_map.at(norm('y', centroid[:y]))
        t_col = Gradient::Map.new(Gradient::Point.new(0, x_col.color, 1.0), Gradient::Point.new(1, y_col.color, 1.0))
        color_point = t_col.at(0.5)
        triangle_color = color_point.color.html
        triangles << [triangle_color, vertices]
        color_index += 1
      end
      triangles
    end

    def image
      @svg.height = @height
      @svg.width  = @width
      @triangles.each do |triangle|
        polygon = triangle[1].flatten.insert(0, "M").insert(3, "L").insert(6, "L").insert(-1, "Z").join(' ')
        @svg.path(polygon, { stroke: triangle[0], fill: triangle[0] })
      end
      @svg
    end

    def build_color_gradient
      gradient_palette = []
      @colors.each_with_index do |color, index|
        step = if index == 0
                index
               elsif index == @colors.length - 1
                1
               else
                (index / @colors.length.to_f).round(2)
               end
        gradient_palette << Gradient::Point.new(step, Color::RGB.from_html(color), 1.0)
      end
      map = Gradient::Map.new(gradient_palette)
      return map
    end

    def centroid(d)
      return {
        x: (d[0][0] + d[1][0] + d[2][0])/3.to_f,
        y: (d[0][1] + d[1][1] + d[2][1])/3.to_f
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
      (num - in_range[0] ) * ( out_range[1] - out_range[0] ) / ( in_range[1] - in_range[0] ).to_f + out_range[0]
    end

    def clamp (num, interval)
      [[num, interval[0]].max, interval[1]].min
    end
  end
end
