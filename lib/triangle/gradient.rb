module Triangle
  class Gradient
    attr_accessor :resolution, :R0, :G0, :B0, :R1, :G1, :B1

    def initialize(start, stop, resolution)
      @resolution = Float(resolution)
      start_hex = start.to_i(16)
      stop_hex = stop.to_i(16)
      @R0 = (start_hex & 0xff0000) >> 16;
      @G0 = (start_hex & 0x00ff00) >> 8;
      @B0 = (start_hex & 0x0000ff) >> 0;

      @R1 = (stop_hex & 0xff0000) >> 16;
      @G1 = (stop_hex & 0x00ff00) >> 8;
      @B1 = (stop_hex & 0x0000ff) >> 0;
    end

    def gradient(step)
      r = interpolate(@R0, @R1, step)
      g = interpolate(@G0, @G1, step)
      b = interpolate(@B0, @B1, step)
      grad = (((r << 8) | g) << 8) | b
      grad.to_s(16)
    end

    private

    def interpolate(start, stop, step)
      if (start < stop)
        return (((stop - start) * (step / @resolution)) + start).round;
      else
        return (((start - stop) * (1 - (step / @resolution))) + stop).round;
      end
    end
  end
end
