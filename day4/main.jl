"""
Reads a file and returns its contents as a string.
"""
function read_file(filename::String)::String
	f = open(filename, "r")
	s = read(f, String)
	close(f)
	return s
end

function chars_to_array(source)
	arr = []
	for line in split(source, "\n")
		c = []
		for char in line
			if char != '\n'
				push!(c, char)
			end
		end
		push!(arr, c)
	end
	return arr
end

function count_xmas(a,b,c,d)
	count = 0;
	if a == 'X' && b == 'M' && c == 'A' && d == 'S'
		count += 1
	end
	if a == 'S' && b == 'A' && c == 'M' && d == 'X'
		count += 1
	end
	return count
end

function count_xmas_horizontal(arr, i, j)
	if i + 3 > length(arr[1])
		return 0
	end
	return count_xmas(arr[j][i], arr[j][i + 1], arr[j][i + 2], arr[j][i + 3])
end

function count_xmas_vertical(arr, i, j)
	if j + 3 > length(arr)
		return 0
	end
	return count_xmas(arr[j][i], arr[j + 1][i], arr[j + 2][i], arr[j + 3][i])
end

function count_xmas_diagonal(arr, i, j)
	if j + 3 > length(arr) || i + 3 > length(arr[1])
		return 0
	end
	return count_xmas(arr[j][i], arr[j + 1][i + 1], arr[j + 2][i + 2], arr[j + 3][i + 3])
end

function count_xmas_diagonal_reverse(arr, i, j)
	if j + 3 > length(arr) || i - 3 < 1
		return 0
	end
	return count_xmas(arr[j][i], arr[j + 1][i - 1], arr[j + 2][i - 2], arr[j + 3][i - 3])
end

function count_xmas(arr)
	count = 0
	width = length(arr[1])
	height = length(arr)
	for i in 1:width
		for j in 1:height
			count += count_xmas_horizontal(arr, j, i)
			count += count_xmas_vertical(arr, j, i)
			count += count_xmas_diagonal(arr, j, i)
			count += count_xmas_diagonal_reverse(arr, j, i)
		end
	end
	return count
end	

function part_one()
	source = read_file("input.txt")
	arr = chars_to_array(source)
	count = count_xmas(arr)
	println(count)
end	

part_one()

function is_mas(a,b,c)
	return (a == 'M' && b == 'A' && c == 'S') || (a == 'S' && b == 'A' && c == 'M')
end

function is_x_mas(arr, i, j)
	if arr[i][j] != 'A'
		return false
	end
	if !is_mas(arr[i-1][j-1], arr[i][j], arr[i+1][j+1])
		return false
	end
	if !is_mas(arr[i+1][j-1], arr[i][j], arr[i-1][j+1])
		return false
	end
	return true
end

function count_x_mas(arr)
	count = 0
	for i in 2:length(arr[1])-1
		for j in 2:length(arr)-1
			if is_x_mas(arr, i, j)
				count += 1
			end
		end
	end
	return count
end

function part_two()
	source = read_file("input.txt")
	arr = chars_to_array(source)
	count = count_x_mas(arr)
	println(count)
end	

part_two()