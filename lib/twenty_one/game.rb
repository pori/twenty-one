require "twenty_one/player"
require "twenty_one/dealer"
require "twenty_one/deck"
require "twenty_one/ace_card"

module TwentyOne
	class Game
		@@BLACKJACK = 21
		@@DEALER_MIN = 17
		@@MAX_BET = 20 
		@@MIN_BET = 1
		@@SHOE_DECKS_COUNT = 4

		def self.play 
			@playing = true
			@phase = :bet

			shoe = [] 

			@@SHOE_DECKS_COUNT.times do
				shoe.concat Deck.new.shuffle
			end

			@dealer = Dealer.new "Harold", shoe

			puts <<-EOS
			You went into the Wolf's Den
			After they made you sign with that pen.
			You said were there to settle a bet.
			The Dealer shuffled his deck.
			“What was your name again?”
			EOS
			puts "Type your name:" 
			name = gets
			@player = Player.new name 
			puts

			while @playing
				case @phase
				when :bet
					puts '"How much would you like to bet?" (minimum of $1)'
					amount = gets.chomp.to_i

					if Chip.get_amount(@player.chips) == 0 
						puts '"You\'re completely out of money, friend. The game is over."'
						@pahse = :gameover
					elsif Chip.get_amount(@player.chips) <= amount
						puts' "You don\'t have enough money to make that bet."'
					elsif amount > 0
						@phase = :deal
					end
				when :deal
					@player.make_bet amount

					puts
					puts "The Dealer dealt the cards"
					puts

					# Deal cards
					2.times do @dealer.hit(@player) end
					2.times do @dealer.hit(@dealer) end	

					puts "You received:"
					puts

					@player.hand.cards.each { |card| puts card }

					puts "The Dealer received a #{@dealer.hand.cards.first.to_s}. He kept the his second card face-down."
					puts

					@phase = :player_turn
				when :side_rules
					#TODO: Side Rules
				when :player_turn
					puts '"What would you like to do?" (type hit or stand)'
				 	choice = gets.chomp	

					case choice
					when "hit"
						@dealer.hit @player

						puts "You received a #{@player.hand.cards.last.to_s}"
						puts

						if @player.hand.cards.last.is_a?(AceCard) && @player.hand.cards.last.name == :ace
							puts "You received an #{@player.hand.cards.last.to_s}."
							puts '"Would you like it to value 1 or 11?" (type 1 or 11)'
							new_ace_value = gets.chomp

							case new_ace_value
							when "1"
									@player.hand.cards.last.use_lower
							when "11"	
									@player.hand.cards.last.use_upper
							end

							puts "Your ace's new value is #{@player.hand.cards.last.value}"
							puts
						end

						if @player.hand.value > @@BLACKJACK
							puts "You received more than 21, which meant you lost."
							puts		
							@phase = :results
						end
					when "stand"
						puts "Then it was The Dealer's turn."
						puts
						@phase = :showdown
					end
				when :dealer_turn
				when :showdown
					puts "The dealer reveals his card!"
					puts "It's a #{@dealer.hand.cards.last.to_s}"
					puts

					while @dealer.hand.value < @@DEALER_MIN && @dealer.hand.value != @@BLACKJACK 
						@dealer.hit(@dealer)

						puts "The dealer drew a #{@dealer.hand.cards.last.to_s}"
					end

					result = @dealer.showdown(@player)

					case result
					when :twenty_one
						puts "21!"	
					when :win
						puts "You won!"
					when :bust
						puts "You lost!"
					when :push
						puts "Tie!"
					end

					@phase = :results
				when :results
					puts "Here were your game stats:"
					puts
					puts "Chips: #{@player.chips.size}"
					puts "Total value: $#{Chip.get_amount(@player.chips)}"
					puts "TwentyOnes: #{@player.twenty_ones}"
					puts "Wins: #{@player.wins}"
					puts "Busts: #{@player.busts}"
					puts "Pushes: #{@player.pushes}"
					puts
					puts '"Play again?"'
					answer = gets.chomp

					case answer
					when "no"
						@playing = false
					when "yes"
						@phase = :bet
					end
				end
			end
		end
	end
end
