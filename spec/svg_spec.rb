require 'spec_helper'

RSpec.describe TrianglePattern::SvgImage do
  context '#<=>' do
    it 'is comparable' do
      svg1 = TrianglePattern::SvgImage.new
      svg2 = TrianglePattern::SvgImage.new

      expect(svg1).to eq svg2
    end
  end
end
