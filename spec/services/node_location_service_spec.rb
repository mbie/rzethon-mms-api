require 'rails_helper'

RSpec.describe NodeLocationService do
  describe "#get_location" do
    subject { described_class.new(name).get_location }
    
    context "zero offset" do
      let(:name) { "MARS-1.3" }

      it "calls location with proper params" do
        timestamp = 1481411108.5978
        time = Time.at(timestamp)

        Timecop.freeze(time) do
          expect_any_instance_of(PlanetLocator).to receive(:position_by_date).with(:mars, 1481411108597, 0)
          subject
        end
      end
    end

    context "any offset" do
      let(:name) { "MARS-3.4" }

      it "calls location with proper params" do
        timestamp = 1481411108.5978
        time = Time.at(timestamp)

        Timecop.freeze(time) do
          expect_any_instance_of(PlanetLocator).to receive(:position_by_date).with(:mars, 1481411108597, Math::PI)
          subject
        end
      end
    end
  end
end
