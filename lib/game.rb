require_relative 'board'
require_relative 'player'
require_relative 'constants'

class Game
	attr_accessor :board, :turn, :player1, :player2
	def initialize
		@board = nil
		@turn = 0
		@player1 = nil
		@player2 = nil
	end

	def get_symbol
		player_symbol = gets.chomp
		if player_symbol.length != 1
			puts "Your symbol should be a single character!"
			get_symbol
		elsif @player1 && @player1.symbol == player_symbol
			puts "This symbol is already taken!"
			get_symbol
		else
			return player_symbol
		end
	end

	def get_player
		puts "Your name:"
		p_name = gets.chomp
		puts "Your symbol, #{p_name}:"
		p_symbol = get_symbol
		return player = Player.new(p_name, p_symbol)
	end

	def add_players
			puts 'Adding first player'
			@player1 = get_player
			puts 'Adding second player'
			@player2 = get_player
	end

	def continue
			puts "press anything to continue"
			continue = gets.chomp
			call_menu
	end

	def valid_board_size?(size)
		return true if size <= 9 && size >= 2
		false
	end

	def add_board
		puts "Choose the size of the board (enter a number between 2 and 9)"
		size = gets.to_i
		if valid_board_size?(size)
			@board = Board.new(size)
		else
			add_board
		end
	end

	def call_menu
		system "clear"
		print "N: start new game\nC: Change players\nB: Change board size\nS: Score\nQ: Quit\n"
		puts "Your choice:"
	    choice = gets.chomp.upcase
	    case choice
		when "N"
			puts "Starting the game"
			add_players if @player1 == nil && @player2 == nil
			add_board if @board == nil
			play
		when "C"
			add_players
			continue
		when "B"
			add_board
			continue
		when "S"
			score
			continue
		when "Q"
		     return
		else
			call_menu	
		end	
	end

	def increment_turn
		@turn+=1
	end

	def play_again?
		puts "Do you wanna play again? (Y/N)"
		answer = gets.chomp.upcase
			if answer == "Y"
				@turn = 0
				@board.clear
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

	def win(player)
		puts "#{player.name} won"
		player.score+=1
	end

	def play
		current_player = @player1
		until @board.player_won?(@player1.symbol) || @board.player_won?(@player2.symbol) || @board.full?
			system "clear"
			board.print_board
			increment_turn
			current_player = turn.odd? ? @player1: @player2
			@board.move(current_player)
		end
		if @board.player_won?(current_player.symbol)
				win(current_player)
		else
			puts "It's a draw"
		end
		board.print_board
		score
		play_again?
	end
end