module Triangle
  class SurfaceTriangulation
    def initialize(width, height, delauny_indicies, points, colors)
      @width = width
      @height = height
      @delauny_indicies = delauny_indicies
      @points = points
      @colors = colors
    end

    def generate_triangles
      triangles = []
      triangle_count = @delauny_indicies.length / 3
      gradient_map = build_color_gradient
      color_index = 0
      (0..@delauny_indicies.length-1).step(3) do |i|
        vertices = [@points[@delauny_indicies[i]], @points[@delauny_indicies[i + 1]], @points[@delauny_indicies[i + 2]]]
        centroid = centroid(vertices)
        x_col = gradient_map.at(norm('x', centroid[:x]).round(4))
        y_col = gradient_map.at(norm('y', centroid[:y]).round(4))
        t_col = Gradient::Map.new(Gradient::Point.new(0, x_col.color, 1.0), Gradient::Point.new(1, y_col.color, 1.0))
        color_step = color_index / triangle_count.to_f
        color_point = t_col.at(color_step.round(4))
        triangle_color = color_point.color.html
        triangles << [triangle_color, vertices]
        color_index += 1
      end
      triangles
    end

    def build_svg
      triangles = generate_triangles
      svg = Victor::SVG.new width:  @width, height: @height, style: { background: '#ddd' }
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

    def build_color_gradient
      gradient_palette = []
      @colors.each_with_index do |color, index|
        if index == 0
          step = 0
        elsif index == @colors.length - 1
          step = 1
        else
          step = (index / @colors.length.to_f).round(2)
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
      (num - in_range[0] ) * ( out_range[1] - out_range[0] ) / (( in_range[1] - in_range[0] ) + out_range[0]).to_f
    end

    def clamp (num, interval)
      [[num, interval[0]].max, interval[1]].min
    end
  end
end
