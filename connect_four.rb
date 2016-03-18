# connect four in ruby!

include Connect_board #board that holds the pieces
include Connect_piece #one pieces

myboard = Board.new
player = 0
while !myboard.has_won()
	myboard.disp()
	myboard.player_move(player%2)
end
myboard.disp_winner()