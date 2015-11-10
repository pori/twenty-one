require "twenty_one/chip"
require "twenty_one/hand"
require "twenty_one/bet"

module TwentyOne
	class Player
		@@STARTING_CHIPS = 100
		attr_reader :name, :chips, :twenty_ones, :wins, :busts, :pushes, :bet, :hand
		attr_accessor :choice 

		def initialize(name)
			@name = name
			@twenty_ones = 0
			@wins = 0
			@busts = 0
			@pushes = 0
			@bet = Bet.new 
			@hand = Hand.new 
			@chips = Chip.generate_chips(:white, 50) 
				.concat Chip.generate_chips(:red, 25)
				.concat Chip.generate_chips(:green, 15)
				.concat Chip.generate_chips(:black, 10)
		end

		def make_bet(amount)
			while @bet.value < amount
				distance_to_total = amount - @bet.value 

				if distance_to_total >= 100   
					chip = take_chip :black
				elsif distance_to_total >= 25 
					chip = take_chip :green
				elsif distance_to_total >= 5 
					chip = take_chip :red
				else  
					chip = take_chip :white
				end		

				if chip.nil?
					return false
				end

				@bet.chips.push chip
			end		

			true	
		end

		def deal_bet(result)
			case result
			when :twenty_one
				@wins += 1
				@twenty_ones += 1
				@chips.concat @bet.payout(:twenty_one) 
			when :win
				@wins += 1
				@chips.concat @bet.payout(:win)
			when :bust
				@busts += 1
			when :push
				@pushes += 1
				@chips.concat @bet.payout(:push)
			end
			
			@hand.clear  
			@bet.clear 
		end

		private

		def take_chip(color)
			idx = @chips.index { |chip| chip.color == color }
			
			if not idx.nil? then
				temp = @chips[idx].clone 
				@chips.delete_at idx

				return temp
			end

			nil
		end
	end
end
