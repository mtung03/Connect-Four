# connect four in ruby

require './Connect_board.rb'

myboard = Board.new
player = 0
last_piece = 000
while !myboard.has_won(last_piece) do 
	myboard.disp()
	last_piece = myboard.player_move((player%2 + 1), last_piece)
	#puts last_piece
	player += 1
end
myboard.disp()
myboard.disp_winner()