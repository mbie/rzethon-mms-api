require 'rails_helper'

RSpec.describe InvalidateNodesService do
  before do
    allow_any_instance_of(NodeService).to receive(:propagate)
    allow(PropagateNodesService).to receive(:call)
  end

  let(:nodes) { [mars] }
  let(:current_node) { build :node }
  let(:mars) do
    {
      name: "MARS_123",
      host: "localhost:3000",
      location_x: 1.23,
      location_y: 2.34,
      location_z: 3.56
    }
  end

  let(:do_call) { -> { described_class.call(nodes, current_node) } }

  context "when there are no nodes" do
    it 'saves new nodes' do
      expect(do_call).to change { Node.count }.by(1)
      node = Node.first
      expect(node.name).to eq("MARS_123")
      expect(node.location_x).to eq(1.23)
    end

    it 'propagates nodes again' do
      expect(PropagateNodesService).to receive(:call).with(current_node)
      do_call.call
    end
  end

  context "when there is existing node" do
    context "but it is different" do
      let!(:existing_node) { create :node, name: "MARS_123", location_x: 3.14 }

      it 'updates existing nodes' do
        expect(do_call).not_to change { Node.count }
        
        expect(existing_node.reload.location_x).to eq(1.23)
      end

      it 'propagates nodes again' do
        expect(PropagateNodesService).to receive(:call).with(current_node)
        do_call.call
      end
    end

    context "attrs are the same" do
      let!(:existing_node) { create :node, **mars }

      it "doesn't change node" do
        expect(do_call).not_to change { Node.count }
        expect(existing_node.reload.location_x).to eq(1.23)
      end

      it 'doesnt propagats nodes again' do
        expect(PropagateNodesService).not_to receive(:call)
        do_call.call
      end
    end
  end

  context "when nothing has changed" do
    it "doesn't propagate nodes" do
      expect_any_instance_of(NodeService).not_to receive(:propagate)
      do_call.call
    end
  end
end
