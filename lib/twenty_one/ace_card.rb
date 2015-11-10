require "twenty_one/face_card"

module TwentyOne
	class AceCard < FaceCard
		@@LOWER_VALUE = 1
		@@UPPER_VALUE = 11

		def initialize(suit)
			super suit, :ace
			@value = @@LOWER_VALUE
		end

		def use_upper
			@value = @@UPPER_VALUE
		end

		def use_lower
			@value = @@LOWER_VALUE
		end
	end
end
