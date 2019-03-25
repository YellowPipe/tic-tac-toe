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

end  