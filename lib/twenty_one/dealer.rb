require "twenty_one/player"

module TwentyOne
	class Dealer < Player
		attr_reader :shoe

		def initialize(name, shoe)
			super name

			@shoe = shoe
		end

		def showdown(player)
			if player.hand.value == @hand.value && player.hand.value <= 21
				player.deal_bet :push	

				@pushes += 1

				return :push
			elsif @hand.value <= 21 && player.hand.value < @hand.value || player.hand.value > 21  
				@chips.push player.bet.chips

				player.deal_bet :bust

				@wins += 1

				return :bust
			else
				win_type = :win

				if player.hand.value == 21
					player.deal_bet :twenty_one
					win_type = :twenty_one
				else
					player.deal_bet :win
				end

				@busts += 1

				return win_type 
			end	
		end

		def hit(player)
			player.hand.cards.push shoe.pop
		end
	end
end
