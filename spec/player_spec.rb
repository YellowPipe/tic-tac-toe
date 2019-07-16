require './lib/player' 

RSpec.describe Board do

  before(:each) do
    @player = Player.new('Test', 'X')
  end
  
  describe "player" do
    it "initializes player with a name" do
      expect(@player.name).to eql('Test')
    end 

    it "initializes player with a sybmol" do
      expect(@player.symbol).to eql('X')
    end 

    it "initializes player with a score of 0" do
      expect(@player.score).to eql(0)
    end 
  end

end