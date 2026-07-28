require_relative "../lib/square"
require_relative "../lib/pieces/knight"

describe Square do
  subject(:square) { described_class.new("white", 0, 0) }

  describe "#add_piece" do
    context "when the provided piece is a Knight" do
      let(:knight) { instance_double(Knight) }

      before do
        allow(knight).to receive(:symbol).and_return("")
      end

      it "contains the knight piece" do
        square.add_piece(knight)
        expect(square.piece).to be(knight)
      end
    end
  end
end
