require 'twenty_one/deck'

include TwentyOne

describe Deck do
	
	before(:each) do
		@deck = Deck.new
	end 

	it 'should have a set of 52 cards' do
		expect(@deck.cards.size).to eq(52)
	end

	describe '#shuffle' do
		it 'should be able to shuffle the deck' do 
			original_card_order = @deck.cards.clone

			@deck.shuffle

			expect(@deck.cards).to_not eq(original_card_order)	
		end
	end

	describe '#draw' do
		it 'should be able to draw a random card and discard it' do
			random_card = @deck.draw

			expect(@deck.cards.first).to_not eq(random_card)
		end
	end

end
