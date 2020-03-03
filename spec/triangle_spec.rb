RSpec.describe TrianglePattern do

  let(:pattern) { TrianglePattern.generate(seed: 100) }

  describe '.generate' do
    context 'same seed returns same output' do
      let(:other_pattern) { TrianglePattern.generate(seed: 100) }
      it { expect(pattern.to_svg).to eq other_pattern.to_svg }
    end
  end

  it "has a version number" do
    expect(TrianglePattern::VERSION).not_to be nil
  end
end
