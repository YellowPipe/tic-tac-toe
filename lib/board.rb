class Board 
	attr_accessor :matrix
	def initialize
		@matrix = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
	end

	def print_board
		counter = 0
		@matrix.each do |val|
			print "|" if counter == 0
			
			if val
				print " #{val} "
			else
				print "   "
			end
			counter+=1
			if counter==3
				counter = 0
				print "|\n" 	
			end
		end 
	end

	def change_matrix(symbol, index)
		@matrix[index] = symbol
	end

	def clear
		@matrix.each {|element| element = nil}
	end

end