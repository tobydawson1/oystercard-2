require 'station'

describe Station.new(1 ,2) do

    it { is_expected.to have_attributes(:zone => 2, :name => 1) }
   
end
