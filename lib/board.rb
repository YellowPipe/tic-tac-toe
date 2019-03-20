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

    def valid_move?(player_input)
    	if valid_input?(player_input)
    		return empty_space?(move_index(player_input))
    	end
    	false
    end

    def valid_input?(arr)
		if arr.length == 2 && 
		(ALPHABET[0...@dim].any? {|val| val == arr[1].upcase}) &&
		((0...@dim).to_a.any? {|element| element == arr[0].to_i})
			return true
		end
		false
	end

	def empty_space?(i)
		@matrix[i].nil?
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
		counter = 0
		print "  "
		@dim.times {|i| print " #{ALPHABET[i]} " }
		print "\n"
		@matrix.each_slice(@dim) do |val|
			print "#{counter}|"
			val.each {|element| print element == nil ? " - " : " #{element} "} 
			print "|\n"
			counter+=1
		end
	end

	def change_matrix(symbol, move_index)
		@matrix[move_index] = symbol
	end

	def clear
		@matrix = Array.new(@dim**2)
	end
end