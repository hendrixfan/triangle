require 'spec_helper'

RSpec.describe Triangle::SvgImage do
  context '#<=>' do
    it 'is comparable' do
      svg1 = Triangle::SvgImage.new
      svg2 = Triangle::SvgImage.new

      expect(svg1).to eq svg2
    end
  end
end
