# connect four in ruby

require './Connect_board.rb'

myboard = Board.new
player = 0

last_piece = 00000
# last piece is a data structure stored in an int to help find runs of four
# each digit corresponds to a value
# [direction][run_size][player][row][column]

while !myboard.has_won(last_piece) do 
	myboard.disp()
	last_piece = myboard.player_move((player%2 + 1), last_piece)
	player += 1
end
myboard.disp()
myboard.disp_winner(player%2)