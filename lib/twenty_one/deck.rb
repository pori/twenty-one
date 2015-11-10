require 'twenty_one/card'
require 'twenty_one/face_card'
require 'twenty_one/ace_card'

module TwentyOne
	class Deck
		@@DECK_LENGTH = 52
		attr_reader :cards

		def initialize
			@cards = [] 

			@cards.concat generate_suit(:clubs)
			@cards.concat generate_suit(:diamonds)
			@cards.concat generate_suit(:hearts)
			@cards.concat generate_suit(:spades)
		end

		def shuffle
			@cards.shuffle!	
		end

		def draw
			@cards.shift	
		end
		
		private

		def generate_suit(suit)
			set = []

			set.push AceCard.new(suit)

			for i  in 2..@@DECK_LENGTH / 4 - 3 
				set.push Card.new suit, i	
			end

			set.push FaceCard.new suit, :jack
			set.push FaceCard.new suit, :queen
			set.push FaceCard.new suit, :king

			set
		end
	end
end
