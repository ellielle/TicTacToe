require "./lib/tic_tac_toe"

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end

describe TicTacToe do
  subject(:tictactoe){ TicTacToe.new }
  describe "#check_tictactoe" do
    context "when top 3 squares are X" do
      let(:square) {{ "1": "X", "2": "X", "3": "X", "4": "4",
                        "5": "5", "6": "6", "7": "7", "8": "8", "9": "9" }}
      it "gives player 1 the win" do
        subject.instance_variable_set(:@squares, square)
        subject.send(:check_tictactoe)
        expect(subject.tictactoe).to be true
      end
    end
    context "when diagonal with O" do
      let(:square) {{ "1": "O", "2": "2", "3": "3", "4": "4",
                        "5": "O", "6": "6", "7": "7", "8": "8", "9": "O" }}
      it "gives player 2 the win" do
        subject.instance_variable_set(:@squares, square)
        subject.instance_variable_set(:@turn, "2")
        subject.send(:check_tictactoe)
        expect(subject.tictactoe).to be true
      end
    end
  end
  describe "#check_input" do
    context "when input is valid" do
      it "returns true" do
        result = subject.send(:check_input, "1")
        expect(result).to be true
      end
    end
    context "when input is invalid" do
      it "returns false" do
        result = subject.send(:check_input, "x")
        expect(result).to be false
      end
    end
  end
  describe "mocking #take_turn" do
    context "when invalid input" do
      it "returns #illegal_input" do
        test_double = double
        allow(test_double).to receive(:take_turn).and_return("\nInvalid move.")
        expect(test_double.take_turn).to eql("\nInvalid move.")
      end
    end
  end
  describe "mocking #check_input" do
    context "when input is invalid" do
      it "returns false" do
        test = double
        allow(test).to receive(:check_input).and_return(false)
        expect(test.check_input).to be false
      end
    end
  end

end