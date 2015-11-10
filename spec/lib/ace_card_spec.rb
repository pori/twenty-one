require "twenty_one/ace_card"

include TwentyOne

describe AceCard do
	before(:each) do
		@ace = AceCard.new :club
	end

	it "should have a value of 1 or 11" do
		expect(@ace.value).to eq(1 || 11) 
	end
	
	describe "#use_upper" do
		it "should use the higher Ace value" do
			@ace.use_upper

			expect(@ace.value).to eq(11)	
		end
	end

	describe "#use_lower" do
		it "should use the lower Ace value" do
			@ace.use_lower

			expect(@ace.value).to eq(1)	
		end
	end
end
