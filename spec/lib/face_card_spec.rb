require 'twenty_one/face_card'

include TwentyOne

describe FaceCard do
	
	it 'should create a playing card value at 10' do
		face_card = FaceCard.new :club, :king

		expect(face_card.value).to eq(10)
	end

end
