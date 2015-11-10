require "twenty_one/card"

module TwentyOne
	class Hand
		attr_reader :cards

		def initialize(cards = [])
			@cards = cards
		end		

		def clear
			@cards = []
		end

		def value
			count = 0

			@cards.each do |card|
				count += card.value
			end

			count
		end
	end
end
