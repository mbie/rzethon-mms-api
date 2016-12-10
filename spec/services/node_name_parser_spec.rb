require 'rails_helper'

RSpec.describe NodeNameParser do
  let(:parser) { described_class.new(name) }

  describe "#raw_name" do
    subject { parser.raw_name }
    
    context "one word" do
      let(:name) { "MARS" }

      it { is_expected.to eq(:mars) }
    end    

    context "full name" do
      let(:name) { "MARS.1-2" }

      it { is_expected.to eq(:mars) }
    end

    context "multiple words" do
      let(:name) { "MARS.1-2.WENUS" }

      it { is_expected.to eq(:mars) }
    end
  end

  describe "#node_number" do
    subject { parser.node_number }
    
    context "one word" do
      let(:name) { "MARS" }

      it { is_expected.to eq(0) }
    end    

    context "full name" do
      let(:name) { "MARS.12-2" }

      it { is_expected.to eq(12) }
    end

    context "multiple numbers" do
      let(:name) { "1212 2" }

      it { is_expected.to eq(1212) }
    end
  end

  describe "#nodes_on_orbit_count" do
    subject { parser.nodes_on_orbit_count }
    
    context "one word" do
      let(:name) { "MARS" }

      it { is_expected.to eq(0) }
    end    

    context "full name" do
      let(:name) { "MARS.12-32" }

      it { is_expected.to eq(32) }
    end

    context "multiple words" do
      let(:name) { "1212 22" }

      it { is_expected.to eq(22) }
    end
  end
end
