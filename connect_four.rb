# connect four in ruby


class Board
	@@cols = [[0, 0, 0, 0, 0],
	   		  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0]]

	# each slot will have either a zero, one, or two

	def initialize

	end
	def player_move(player)
		index = gets.chomp.to_i - 1
		column = @@cols[index]

		i = 0
		if is_full(column)
			puts "invalid, column is full"
			return player_move(player)
		end

		while column[i] == 0 and i < column.length do
			i += 1
		end

		column[i-1] = player
	end
	def disp
		puts '   1   2   3   4   5  '
		j = 0
		while j < @@cols.length do
			line = ''
			i = 0
			while i < (@@cols[j]).length do 
				line += ' | ' + @@cols[i][j].to_s
				i += 1
			end
			line += ' |'
			puts ' ---------------------'
			puts line
			j += 1
		end
		puts ' ---------------------'
	end
	def has_won

	end
	def disp_winner

	end
	def is_full(column)
		has_zero = false
		i = 0
		while i < column.length do
			if column[i] == 0 
				has_zero = true
				break
			end
			i += 1
		end
		!has_zero
	end
end

myboard = Board.new
player = 1
while true do #!myboard.has_won()
	myboard.disp()
	myboard.player_move(player%2 + 1 )
	player += 1
end
myboard.disp()
#myboard.disp_winner()