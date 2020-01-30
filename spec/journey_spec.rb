require 'journey'

describe Journey do

    it { respond_to(:store_journey) }

    it 'has an empty list of journeys by default' do
        expect(subject.journeys).to be_empty 
      end

end