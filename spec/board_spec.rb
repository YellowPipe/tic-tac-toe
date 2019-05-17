require './lib/board' 

RSpec.describe Board do
  describe "initialize" do
    it "returns an array with nil cells value" do
      board = Board.new(3)
      expect(board.matrix).to eql([nil,nil,nil,nil,nil,nil,nil,nil,nil])
    end
    it "returns an array with combinaisons win value" do
      board = Board.new(3)
      expect(board.win_combinations).to eql([[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],
      	[2, 5, 8],[0, 4, 8],[2, 4, 6]])
    end

  end
  

  describe "full?" do
    it "returns false if there is cells = nil" do
      board = Board.new(3)
      board.matrix = ["x","x","o",nil,nil,nil,nil,nil,nil]
      expect(board.full?).to eql(false)
    end

    it "returns true if there is no cells = nil" do
      board = Board.new(3)
      board.matrix = ["x","x","o","o","x","o","x","o","x"]
      expect(board.full?).to eql(true)
    end  
  end

  describe "player_won" do
  	it "return true if the player puts his symbol in all the cells of one of win combinaisons" do
      board = Board.new(3)
  		board.matrix = ["x","x","x","o","o","nil","nil","nil","nil"]
  		expect(board.player_won?("x")).to eql(true)
  	end	
  end

  describe "change_matrix" do 
    
    it "changes the matrix" do
    board = Board.new(3)
    board.change_matrix('x', 3) 
      expect(board.matrix[3]).to eql('x')
    end
    it 'does not change other elements' do
      board = Board.new(3)
      board.change_matrix('x', 3)
      expect(board.matrix[0]).to eql(nil)
    end
  end

  describe "clear" do 
    it "clears the matrix" do
      board = Board.new(3)
      board.change_matrix('x', 3) 
      board.clear 
      expect(board.matrix).to all(be_nil)
    end
  end
end