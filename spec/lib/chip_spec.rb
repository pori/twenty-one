require 'twenty_one/chip'

include TwentyOne

describe Chip do
	
	it 'should value $1 if it is white' do
		white = Chip.new :white

		expect(white.value).to eq(1)
	end

	it 'should value $5 if it is red' do
		red = Chip.new :red

		expect(red.value).to eq(5)
	end

	it 'should value $25 if it is green' do
		green = Chip.new :green

		expect(green.value).to eq(25)
	end

	it 'should value $100 if it is black' do
		black = Chip.new :black

		expect(black.value).to eq(100)
	end

	describe '#generate_chips(color, amount)' do
		it 'should generate a set of chips of a specific color' do
			chips = Chip.generate_chips :white, 50

			expect(chips.size).to eq(50)
		end
	end	

	describe '#get_amount(chips)' do
		it 'should get the total amount of money a set of chips is worth' do
			chips = [Chip.new(:white), Chip.new(:red), Chip.new(:green), Chip.new(:black)]	

			expect(Chip.get_amount(chips)).to eq(131)
		end
	end

end
