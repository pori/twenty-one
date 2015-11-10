require "twenty_one/player"
#require "twenty_one/bet"
require "twenty_one/hand"

include TwentyOne

describe Player do
	before(:each) do
		@player = Player.new "Pori"
	end

	it "should have a name" do
		expect(@player.name).to eq("Pori")	
	end

	it "should start with 100 chips" do
		expect(@player.chips.size).to eq(100)
	end

	it "should start with no wins" do
		expect(@player.wins).to eq(0)
	end

	it "should start with no losses" do
		expect(@player.busts).to eq(0)
	end

	it "should start with no ties" do
		expect(@player.busts).to eq(0)
	end

	it "should start with an empty bet" do
		expect(@player.bet.value).to eq(0)
	end

	it "should start with no cards in hand" do
		expect(@player.hand.value).to eq(Hand.new.value)
	end

	it "should start with no choices made" do
		expect(@player.choice).to eq(nil)
	end

	describe "#make_bet(amount)" do
		it "should remove some chips from the player for the bet" do
			chips_count = @player.chips.size
			@player.make_bet 100

			expect(chips_count).to_not eq(@player.chips.size)
		end

		it "should have added chips to the bet" do
			@player.make_bet 100

			expect(@player.bet.value).to_not eq(0)
		end

		it "should successfully make a bet" do
			temp_player = Player.new "Sergey Brin"
			bet = temp_player.make_bet 100

			expect(bet).to eq(true)
		end

		it "should fail if too high of a bet is made" do
			temp_player = Player.new "Yukihiro"
			bet = temp_player.make_bet 10000

			expect(bet).to eq(false)
		end
	end

	describe "#deal_bet(result)" do
		it "should add to the player's win column" do
			@player.deal_bet :win

			expect(@player.wins).to eq(1)
		end

		it "should empty the player's bet" do
			@player.deal_bet :win

			expect(@player.bet.value).to eq(0)
		end

		it "should empty the player's hand" do
			@player.deal_bet :win

			expect(@player.hand.value).to eq(0)
		end

		it "should add the player's winnings to the chips set" do
			@player.make_bet 100
			@player.deal_bet :win

			expect(@player.chips.size).to be > 100
		end

		it "should add to the player's loss column" do
			temp_player = Player.new "Ken Thompson"

			temp_player.make_bet 100
			temp_player.deal_bet :bust

			expect(temp_player.busts).to eq(1)
		end

		it "should lose chips when a player busts" do
			temp_player = Player.new "Dennis Ritchie"

			temp_player.make_bet 100
			temp_player.deal_bet :bust

			expect(temp_player.chips.size).to be < 100
		end

		it "should increase the tie column where there is a push" do
			temp_player = Player.new "Linus Torvalds"

			temp_player.make_bet 100
			temp_player.deal_bet :push

			expect(temp_player.pushes).to eq(1)
		end

		it "should restore the original amount of chips where there is a push" do
			temp_player = Player.new "Richard Stallman"

			temp_player.make_bet 100
			temp_player.deal_bet :push

			expect(temp_player.chips.size).to be(100)
		end
	end
end
