require "twenty_one/chip"
require "twenty_one/player"

module TwentyOne
	class Bet
		attr_reader :chips

		def initialize()
			@chips = [] 
		end

		def present(chips)
			@chips = chips
		end

		def value
			Chip.get_amount(@chips)
		end

		def payout(type)
			res = []

			if type == :twenty_one
				payout_generator = Player.new "Temporary player"
				
				payout_generator.make_bet value * 2.5
				
				res.concat payout_generator.bet.chips
				payout_generator = nil
			elsif type == :push
				res.concat @chips
			else
				2.times do res.concat @chips end 
			end	

			@chips = []
			res
		end

		def clear
			@chips = []
		end
	end
end
