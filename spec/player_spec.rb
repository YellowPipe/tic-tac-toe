require './lib/player'
RSpec.describe Player do
  describe "initialize" do
    it "initialize a player" do
      p = Player.new("zina","x")
      expect(p.name).to eq("zina")
      expect(p.symbol).to eql("x")
    end
  end
end  