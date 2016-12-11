require "rails_helper"

RSpec.describe SubmissionsController, :type => :controller do
  describe "POST #create" do
    let(:node_params) do
      {
        name: "MARS-123",
        host: "localhost:3000",
        location_x: 123.2,
        location_y: 123.2,
        location_z: 123.2,
      }
    end

    let(:do_create) { -> { post :create, params: { node: node_params } } }

    it "saves node" do
      expect { do_create.call }.to change { Node.count }.by(1)
      expect(response).to have_http_status(200)
      expect(Node.first.name).to eq("MARS-123")
    end

    it "renders returns success response" do
      do_create.call
      expect(response).to be_success
    end

    it "updates existing record" do
      node = create :node, name: "MARS-123", host: "123"
      expect { do_create.call }.to change { node.reload.updated_at }
      expect(node.host).to eq("localhost:3000")
    end

    it "returns error" do
      node_params.delete(:host)
      expect { do_create.call }.not_to change { Node.count }
      expect(response).to have_http_status(422)
    end
  end
end
