require "twenty_one/card"

include TwentyOne

describe Card do

	before(:each) do
		@card = Card.new :spades, 2
	end

	it "should have a type corresponding to a playing card" do
		expect(@card.suit).to eq(:spades)
	end

end
