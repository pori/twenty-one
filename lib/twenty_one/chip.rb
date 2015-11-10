module TwentyOne
	class Chip
		attr_reader :color, :value

		def initialize(color)
			@color = color

			case color
			when :white
				@value = 1
			when :red
				@value = 5
			when :green
				@value = 25 
			when :black
				@value = 100
			end
		end

		def self.generate_chips(color, total)
			set  = []

			total.times do
				set.push Chip.new(color)	
			end

			set
		end

		def self.get_amount(chips)
			amount = 0

			chips.each do |chip|
				amount += chip.value
			end

			amount
		end
	end
end
