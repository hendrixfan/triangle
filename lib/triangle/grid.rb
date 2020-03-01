module Triangle
  class Grid

    def initialize(width, height, cell_size, variance, seed)
      @width = width
      @height = height
      @cell_size = cell_size
      @variance = variance
      @seed = seed
      @calc_variance = cell_size * variance / 2.to_f
      cells_x = ((@width + 4 * @cell_size) / @cell_size).floor
      cells_y = ((@height + 4 * @cell_size) / @cell_size).floor
      @bleed_x = ((cells_x * @cell_size) - width) / 2
      @bleed_y = ((cells_y * @cell_size) - height) / 2
    end

    def generate_grid
      half_cell_size = (@cell_size / 2.to_f).round
      double_v = @calc_variance * 2
      negative_v = -@calc_variance
      grid = []
      prng1 = Random.new(@seed)
      h = @height + @bleed_y
      w = @width + @bleed_x
      i = -@bleed_x
      j = -@bleed_y
      (-@bleed_x..w-@bleed_x).step(@cell_size) do |i|
        (-@bleed_y..h-@bleed_x).step(@cell_size) do |j|
          x = (i + half_cell_size) + (prng1.rand * double_v + negative_v)
          y = (j + half_cell_size) + (prng1.rand * double_v + negative_v)
          grid << [x.floor, y.floor]
        end
      end
      grid
    end
  end
end
