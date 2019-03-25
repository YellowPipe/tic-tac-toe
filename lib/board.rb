class Board 
	attr_accessor :matrix, :win_combinations, :dim
	def initialize(dim)
		@matrix = Array.new(dim**2)
		@win_combinations = init_combin(dim)
		@dim = dim
	end
  
  	def init_combin(dim)
  		arr = []
        arr  += Array.new(dim) { |element1| Array.new(dim){|element2| dim * element1 + element2 }}  
        arr  += Array.new(dim) { |element1| Array.new(dim){|element2|  element1 + (element2*dim)}}
        arr  += Array.new(1) { |element1| Array.new(dim){|element2|  element2+ (element2*dim)}}
        arr  += Array.new(1) { |element1| Array.new(dim){|element2|  element2*(dim-1) + (dim-1)}}
        return arr                      
    end

    def move_index(player_input)
    	@dim*(player_input[0].to_i)+ALPHABET.index(player_input[1].upcase)
    end

    def full?
		@matrix.none? {|val| val == nil} 
	end

	def player_won?(symbol)
		@win_combinations.each do |element|
	       return true if element.all?{|val| @matrix[val] == symbol}                    
      	end
		false
	end

	def print_board
		print "  "
		@dim.times {|i| print " #{ALPHABET[i]} " }
		print "\n"
		@matrix.each_slice(@dim).with_index do |val, i|
			print "#{i}|"
			val.each {|element| print element == nil ? " - " : " #{element} "} 
			print "|\n"
		end
	end

	def change_matrix(symbol, move_index)
		@matrix[move_index] = symbol
	end

	def clear
		@matrix = Array.new(@dim**2)
	end
end