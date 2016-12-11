require 'rails_helper'

RSpec.describe NodesDistanceCalculator do
  let(:node_1) { double(:node_1, location: location_1) }
  let(:node_2) { double(:node_2, location: location_2) }

  subject { described_class.new(node_1, node_2).call }

  context "locations are 0" do
    let(:location_1) { Location.new(0, 0,0) }
    let(:location_2) { Location.new(0, 0,0) }

    it { is_expected.to eq(0) }
  end

  context "locations are the same" do
    let(:location_1) { Location.new(1, 1, 1) }
    let(:location_2) { Location.new(1, 1, 1) }

    it { is_expected.to eq(0) }
  end

  context "distance is simple" do
    let(:location_1) { Location.new(1, 1, 1) }
    let(:location_2) { Location.new(0, 0, 0) }

    it { is_expected.to be_within(0.01).of(1.732) }
  end

  context "distance is simple, points are negative" do
    let(:location_1) { Location.new(-1, -1, -1) }
    let(:location_2) { Location.new(0, 0, 0) }

    it { is_expected.to be_within(0.01).of(1.732) }
  end

  context "distance is more difficult" do
    let(:location_1) { Location.new(-0.168264, -0.985469, 1) }
    let(:location_2) { Location.new(-1.525113, 0.034583, 0.038281) }

    it { is_expected.to be_within(0.00001).of(1.95101) }
  end
end
