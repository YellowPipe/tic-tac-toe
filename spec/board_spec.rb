require './lib/board' 

RSpec.describe Board do

  before(:each) do
    @board = Board.new(3)
  end
  
  describe "full?" do
    it "returns false if there is cells = nil" do
      @board.matrix = ["x","x","o",nil,nil,nil,nil,nil,nil]
      expect(@board.full?).to eql(false)
    end

    it "returns true if there is no cells = nil" do
      @board.matrix = ["x","x","o","o","x","o","x","o","x"]
      expect(@board.full?).to eql(true)
    end  
  end

  describe "player_won" do
  	it "return true if the player puts his symbol in all the cells of one of win combinaisons" do
  		@board.matrix = ["x","x","x","o","o","nil","nil","nil","nil"]
  		expect(@board.player_won?("x")).to eql(true)
  	end

    it "return true if the player puts his symbol in all the cells of diagonal of win combinaisons" do
      @board.matrix = ["x","o","o","nil","x","nil","nil","nil","x"]
      expect(@board.player_won?("x")).to eql(true)
    end

    it "return true if the player puts his symbol in all the cells of vertical of win combinaisons" do
      @board.matrix = ["x","o","o","x","nil","nil","x","nil","nil"]
      expect(@board.player_won?("x")).to eql(true)
    end
    it 'does not return true if all the cells are full but there is no win combination' do 
      @board.matrix = ["x","o","o","o","x","x","x","o","o"]
      expect(@board.player_won?("x")).to eql(false)
    end
  end


  describe "change_matrix" do 
    
    it "changes the matrix" do
    @board.change_matrix('x', 3) 
      expect(@board.matrix[3]).to eql('x')
    end
    it 'does not change other elements' do
      @board.change_matrix('x', 3)
      expect(@board.matrix[0]).to eql(nil)
    end
  end

  describe "clear" do 
    it "clears the matrix" do
      @board.change_matrix('x', 3) 
      @board.clear 
      expect(@board.matrix).to all(be_nil)
    end
  end
end