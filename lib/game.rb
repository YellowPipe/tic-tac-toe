require_relative 'board'
require_relative 'player'
require_relative 'constants'

class Game
	attr_accessor :board, :turn, :player1, :player2
	def initialize
		@board = Board.new
		@turn = 0
		@player1 = nil
		@player2 = nil
	end

	def add_player(symbol)
		player_name = gets.chomp
		return Player.new(player_name, symbol)
	end

	def move(player)
		symbol = player.symbol
		puts "#{player.name} move (print a number from 0 to 8) \n"
		move_index = gets.chomp
		if board.matrix[move_index.to_i] == nil && move_index.to_i >= 0 && move_index.to_i < 9 && POSSIBLE_MOVES.any? {|element| element == move_index} 
			board.change_matrix(player.symbol, move_index.to_i)
		else
			puts 'Please make a valid move'
			move(player)
		end
	end	

	def board_full?
		!board.matrix.any? {|val| val == nil} 
	end

	def player_won?
		WIN_CONDITIONS.each do |val|
			if  @board.matrix[val[0]] == @board.matrix[val[1]] && 
			 	@board.matrix[val[1]] == @board.matrix[val[2]] &&
			 	@board.matrix[val[0]] != nil && @board.matrix[val[1]] != nil && @board.matrix[val[2]] != nil
			 	return true
			end
		end
		return false
	end

	def change_names
			puts "player1 name:"
			@player1 = add_player('X')
			puts "player2 name:"
			@player2 = add_player('O')
	end

	def continue
			puts "press anything to continue"
			continue = gets.chomp
			call_menu
	end

	def call_menu
		system "clear"
		print MENU
		puts "Your choice:"
	    choice = gets.chomp.upcase
	    case
		when choice == "N"
			game_start
		when choice == "C"
			change_names
			continue
		when choice == "S"
			score
			continue
		when choice == "Q"
		     return	
		end	
	end

	def game_start
		puts "Starting the game"
		if @player1 == nil && @player2 == nil
			change_names
		end
		play
	end

	def increment_turn
		@turn+=1
	end

	def play_again?
		puts "Do you wanna play again? (Y/N)"
		answer = gets.chomp.upcase
			if answer == "Y"
				@turn = 0
				@board = Board.new
				call_menu
			elsif answer == "N"
				puts 'Bye'
				return
			else	
				play_again?
			end
	end

	def score
		if @player1 && @player2
			puts "Score:\n #{@player1.name}: #{@player1.score}\n #{@player2.name}: #{player2.score}"
		else
			puts "No players added"
		end
	end

	def play
		until player_won? || board_full?
			system "clear"
			board.print_board
			increment_turn
			current_player = turn%2!=0? @player1: @player2
			move(current_player)
		end
		if player_won?
			puts turn%2!=0? "#{@player1.name} won" : "#{@player2.name} won"
			if turn%2!=0
				puts "#{@player1.name} won"
				@player1.score+=1
			else
				puts "#{@player2.name} won"
				@player2.score+=1
			end
		else
			puts "It's a draw"
		end
		score
		play_again?
	end
end