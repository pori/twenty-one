require "twenty_one/bet"
require "twenty_one/chip"
require "twenty_one/player"

include TwentyOne

describe Bet do
	before(:each) do
		@bet = Bet.new
	end

	it "should start with an empty chip set" do
		expect(@bet.chips).to eq([])
	end

	describe "#present(chips)" do
		it "should take in some chips" do
			@bet.present [Chip.new(:white), Chip.new(:red)]

			expect(@bet.chips).to_not eq([])
		end
	end

	describe "#value()" do
		it "should get the value of bet's chips" do
			temp_bet = Bet.new

			temp_bet.present [Chip.new(:white), Chip.new(:red)]

			expect(temp_bet.value).to_not eq(0)
		end
	end

	describe "#payout(player)" do
		it "should give back double the originally bet chips for a regular win" do
			chips = @bet.chips

			chips.concat @bet.chips

			expect(@bet.payout(:win)).to eq(chips)
		end

		it "should give back two and a half times the originally bet chips for a twenty_one" do

		end

		it "should increase a player's chip count" do
			temp_player = Player.new "Alex"
			bet = Bet.new
			bet.present [Chip.new(:white), Chip.new(:red)]

			temp_player.chips.concat bet.payout(:win)

			expect(temp_player.chips.size).to be > 100
		end
	end

	describe "#clear()" do
		it "should clear out the bet's chips" do
			@bet.clear

			expect(@bet.value).to eq(0)
		end
	end
end
