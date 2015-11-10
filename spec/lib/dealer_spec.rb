require "twenty_one/dealer"
require "twenty_one/player"
require "twenty_one/deck"
require "twenty_one/card"
require "twenty_one/ace_card"
require "twenty_one/face_card"

include TwentyOne

describe Dealer do
	before(:each) do
		shoe = []
		4.times do
				shoe.concat Deck.new.cards
		end

		@dealer = Dealer.new "Ken Thompson", shoe
		@player = Player.new "Dennis Ritchie"
	end

	it "should start with a pretty big selection of cards" do
		expect(@dealer.shoe.size).to be >= 52
	end	

	describe "#showdown(player)" do
		it "should push if there is a tie" do
			@player.make_bet 100

			@player.hand.cards.concat [Card.new(:diamonds, 2), Card.new(:spades, 3)]
			@dealer.hand.cards.concat [Card.new(:hearts, 2), Card.new(:clubs, 3)]

			result = @dealer.showdown @player

			expect(result).to eq(:push)
		end

		it "should report a bust if the player loses" do
			@player.make_bet 100
			
			ace_card = AceCard.new :clubs

			ace_card.use_upper

			@dealer.hit @player
			@dealer.hand.cards.concat [ace_card, Card.new(:clubs, 6)]

			result = @dealer.showdown @player

			expect(result).to eq(:bust)
		end	

		it "should report a win if the player wins" do
			@player.make_bet 100

			ace_card = AceCard.new :clubs

			ace_card.use_upper

			@player.hand.cards.concat [ace_card, Card.new(:spade, 5)]
			@dealer.hit(@dealer)

			result = @dealer.showdown @player

			expect(result).to eq(:win)
		end
	end

	describe "#hit(player)" do
		it "should add a card to the player's hand" do
			@dealer.hit @player

			expect(@player.hand.cards.size).to be > 0
		end
	end
end
