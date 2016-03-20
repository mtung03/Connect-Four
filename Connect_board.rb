# Connect_board.rb 

class Board
	@@cols = [[0, 0, 0, 0, 0],
	   		  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0]]

	# each slot will have either a zero, one, or two

	def player_move(player, last_piece)
		index = gets.chomp.to_i - 1 # change to zero-based

		if index >= @@cols.length
			puts 'invalid column'
			return player_move(player, last_piece)
		end

		column = @@cols[index]

		if is_full(column)
			puts "invalid, column is full"
			return player_move(player, last_piece)
		end

		i = 0
		while column[i] == 0 and i < column.length do
			i += 1
		end

		@@cols[index][i-1] = player # set slot to player's chip

		last_piece = dig_put(0, index+1, last_piece) # col of move
		last_piece = dig_put(1, i, last_piece) 		 # row of move
		last_piece = dig_put(2, player, last_piece)  # player moved
		return last_piece
	end

	def disp
		puts '   1   2   3   4   5  '

		(0..@@cols.length-1).each do |j|
			line = ''

			(0..(@@cols[j]).length-1).each do |i|
				line += ' | ' + @@cols[i][j].to_s
			end

			line += ' |'
			puts ' ---------------------'
			puts line
		end
		puts ' ---------------------'
	end

	def has_won(last_piece)
		if dig_get(2, last_piece) == 0 #player must be 1 or 2
			return false
		end

		last_piece = dig_put(3, 1, last_piece) # run starts at 1

		(1..8).each do |i|
			last_piece = dig_put(4, i, last_piece) # change direction
			if check_run(last_piece)
				return true
			end
		end

		return false
	end

	def disp_winner(player)
		puts "player #{player} wins"
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

	def check_run(last_piece)

		# extract values
		col = dig_get(0, last_piece) 
		row = dig_get(1, last_piece) 
		player = dig_get(2, last_piece) 
		run = dig_get(3, last_piece) 
		dir = dig_get(4, last_piece) 

		if col <= 0 or col > @@cols.length # one-based for row/col
			return false
		elsif row <= 0 or row > @@cols[0].length
			return false
		elsif @@cols[col-1][row-1] != player
			return false
		elsif run == 4
			return true
		else
			last_piece = dig_put(3, run + 1, last_piece) 

			columns = [-1, 0, 1, 1, 1, 0, -1, -1]
			rows_ind = [-1, -1, -1, 0, 1, 1, 1, 0]
			last_piece = dig_put(0, (col + columns[dir-1]), last_piece)
			last_piece = dig_put(1, (row + rows_ind[dir-1]), last_piece)
			return check_run(last_piece)
		end
	end
end



# functions for getting and seting specific digits in the last_piece data struct
def dig_put(index, dig, num)
	num = num - (dig_get(index, num)*(10**index))
	num + ((10**index)*dig)
end

def dig_get(index, num)
	(num%(10**(index+1)))/(10**index)
end