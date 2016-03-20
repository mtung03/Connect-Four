# Connect_board.rb 

class Board
	@@cols = [[0, 0, 0, 0, 0],
	   		  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0],
			  [0, 0, 0, 0, 0]]

	# each slot will have either a zero, one, or two

	def initialize

	end
	def player_move(player, last_piece)
		index = gets.chomp.to_i - 1
		column = @@cols[index]

		i = 0
		if is_full(column)
			puts "invalid, column is full"
			return player_move(player, last_piece)
		end

		while column[i] == 0 and i < column.length do
			i += 1
		end

		column[i-1] = player
		last_piece = dig_put(0, index+1, last_piece) #+= index + 1
		last_piece = dig_put(1, i, last_piece) #+= (i)*10
		last_piece = dig_put(2, player, last_piece) #+= player*100
		return last_piece
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
	def has_won(last_piece)
		if dig_get(2, last_piece) == 0 
			return false
		end
		last_piece = dig_put(3, 1, last_piece) #+= 1_000
		last_piece = dig_put(4, 1, last_piece) #+= 10_000
		#puts last_piece
		(1..8).each do |i|
			last_piece = dig_put(4, i, last_piece) #+= 10_000
			if check_run(last_piece)
				return true
			end
		end

		return false
	end
	def disp_winner
		puts "you win"
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
		col = dig_get(0, last_piece) # last_piece%10
		row = dig_get(1, last_piece) #(last_piece%100)/10
		player = dig_get(2, last_piece) #(last_piece%1000)/100
		run = dig_get(3, last_piece) #(last_piece%10_000)/1000
		dir = dig_get(4, last_piece) #last_piece/10_000

		if col <= 0 or col > @@cols.length # one-based for row/col
			#print 'col bound '
			return false
		elsif row <= 0 or row > @@cols[0].length
			#print 'row bound '
			return false
		elsif @@cols[col-1][row-1] != player
			#print 'not run '
			return false
		elsif run == 4
			#print 'full run '
			return true
		else
			#print 'part run '
			last_piece = dig_put(3, run + 1, last_piece) #+= 1000

			columns = [-1, 0, 1, 1, 1, 0, -1, -1]
			rows_ind = [-1, -1, -1, 0, 1, 1, 1, 0]
			last_piece = dig_put(0, (col + columns[dir-1]), last_piece)
			last_piece = dig_put(1, (row + rows_ind[dir-1]), last_piece)
			return check_run(last_piece)
		end
	end
end

def dig_put(index, dig, num)
	num = num - (dig_get(index, num)*(10**index))
	num + ((10**index)*dig)
end
def dig_get(index, num)
	(num%(10**(index+1)))/(10**index)
end