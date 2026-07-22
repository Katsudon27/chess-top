require_relative "../lib/square"
require_relative "../lib/pieces/knight"

describe Square do
  subject(:square) { described_class.new("\u25A1", 0, 0) }

  describe "#add_piece" do
    context "when the provided piece is a Knight" do
      let(:knight) { instance_double(Knight) }

      it "contains the knight piece" do
        square.add_piece(knight)
        expect(square.piece).to be(knight)
      end
    end
  end
end
