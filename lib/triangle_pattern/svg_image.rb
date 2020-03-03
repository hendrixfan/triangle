module TrianglePattern
  class SvgImage
    include Comparable

    private

    attr_reader :svg_string

    public

    attr_reader :height, :width

    def initialize
      @width      = 100
      @height     = 100
      @svg_string = ''
    end

    def width=(width)
      @width = width.floor
    end

    def height=(height)
      @height = height.floor
    end

    def include?(string)
      body.include? string
    end

    def svg_header
      %(<svg xmlns="http://www.w3.org/2000/svg" width="#{@width}" height="#{@height}">)
    end

    def svg_closer
      '</svg>'
    end

    def to_s
      svg_header + svg_string + svg_closer
    end

    def body
      svg_string
    end

    def <<(svg)
      svg_string << svg.body
    end

    def path(str, args = {})
      svg_string << %(<path d="#{str}" #{write_args(args)} />)
    end

    def group(elements, args = {})
      svg_string << %(<g #{write_args(args)}>)
      elements.each { |e| eval e }
      svg_string << %(</g>)
    end

    def write_args(args)
      str = ''
      args.each do |key, value|
        if value.is_a?(Hash)
          str << %(#{key}=")
          value.each do |k, v|
            str << %(#{k}:#{v};)
          end
          str << %(" )
        else
          str << %(#{key}="#{value}" )
        end
      end
      str
    end

    def self.as_comment(str)
      "<!-- #{str} -->"
    end

    def <=>(other)
      to_s <=> other.to_s
    end
  end
end
