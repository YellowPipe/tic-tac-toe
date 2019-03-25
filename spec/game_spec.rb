require './lib/game'
require './lib/player'
RSpec.describe Game do
game = Game.new

  describe "valid_symbol?" do
	game.player1 = Player.new('name', 'X')
    it "returns false if sumbol is longer than single character" do
    	expect(game.valid_symbol?('ab')).to be false 
    end
    it "returns false if symbol is taken by another player" do
    	expect(game.valid_symbol?('X')).to be false
    end
    it 'returns true if all is good' do 
    	expect(game.valid_symbol?('O')).to be true
  	end
  end


  describe "valid_board_size?" do
  	it "returns false if player asks input is higher than 9" do
    	expect(game.valid_board_size?(10)).to be false 
    end
    it "returns false if player asks input is less than 2" do
    	expect(game.valid_board_size?(1)).to be false 
    end
	it 'returns true if all is good' do 
    	expect(game.valid_board_size?(5)).to be true
  	end
  end


  describe "want_to_quit?" do
    it "should return true if length of the array is one and his value is q" do
      expect(game.want_to_quit?(['q'])).to be true
    end  
    it "should return false if length of the array is great than one and his value is not q" do
      expect(game.want_to_quit?([3,'B'])).to be false
    end  
  end  

end  