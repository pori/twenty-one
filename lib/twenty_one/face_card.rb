require 'twenty_one/card'

module TwentyOne
	class FaceCard < Card
		attr_reader :name

		def initialize(suit, name)
			super suit, 10
			@name = name
		end

		def to_s
			"#{@name} of #{@suit}"
		end
	end
end
