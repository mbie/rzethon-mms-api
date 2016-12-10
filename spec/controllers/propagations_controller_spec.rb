require "rails_helper"

RSpec.describe PropagationsController, :type => :controller do
  describe "POST #create" do
    let(:node_params) do
      {
        name: "MARS-123",
        host: "localhost:3000",
        location_x: 123.2,
        location_y: 123.2,
        location_z: 123.2
      }
    end

    let(:do_create) { -> { post :create, params: { nodes: [node_params] } } }

    it "calls UpdateHostsService" do
      expect(InvalidateNodesService).to receive(:call).with(kind_of(Array), anything())
      do_create.call
    end
  end
end
