class Board 
	attr_accessor :matrix, :win_combinations, :dim
	def initialize(dim)
		@matrix = Array.new(dim**2)
		@win_combinations = init_combin(dim)
		@dim = dim
	end
  
  	def init_combin(dim)
  		arr = []
        arr  += Array.new(dim ){|l| Array.new(dim){|i| dim * l + i }}  
        arr  += Array.new(dim){|l| Array.new(dim){|i|  l + (i*dim)}}
        arr  += Array.new(1){|l| Array.new(dim){|i|  i+ (i*dim)}}
        arr  += Array.new(1){|l| Array.new(dim){|i|  i*(dim-1) + (dim-1)}}
        return arr                      
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
		return true if @matrix[i] == nil
		false
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
			val.each {|element| print element == nil ? "   " : " #{element} "} 
			print "|\n"
			counter+=1
		end
	end

	def change_matrix(symbol, move_index)
		@matrix[move_index] = symbol
	end

	def move(player)
		symbol = player.symbol
		puts "#{player.name} move (print a number from 0 to #{@dim-1} and a letter from A to #{ALPHABET[@dim-1]}) \n"
		player_input = gets.gsub(/\s+/, "").split('')
		if valid_input?(player_input)
			move_index = @dim*(player_input[0].to_i)+ALPHABET.index(player_input[1].upcase)
			if empty_space?(move_index)
				change_matrix(player.symbol, move_index)
			else
				puts 'Invalid move'
				move(player)
			end
		else
			puts 'Please make a valid move0'
			move(player)
		end
	end	

	def clear
		@matrix = Array.new(dim**2)
	end
end