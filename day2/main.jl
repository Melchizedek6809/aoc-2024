"""
Reads a file and returns its contents as a string.
"""
function read_file(filename::String)::String
	f = open(filename, "r")
	s = read(f, String)
	close(f)
	return s
end


"""
Parses a line into two integers.
"""
function parse_line(line::SubString{String})
	return map(x -> parse(Int64, x), split(line, " "))
end

function is_safe_line(line::Vector{Int64})::Bool
	increases = 0
	decreases = 0
	max_diff = 0
	min_diff = 99

	for i in 1:length(line) - 1
		if line[i] < line[i + 1]
			increases += 1
		else
			decreases += 1
		end
		diff = abs(line[i + 1] - line[i])
		max_diff = max(max_diff, diff)
		min_diff = min(min_diff, diff)
	end

	return !((increases > 0 && decreases > 0) || (min_diff < 1) || (max_diff > 3))
end

function part_one()
	lines = split(read_file("input.txt"), "\n")
	safe_lines = 0
	for line in lines
		safe_lines += is_safe_line(parse_line(line)) ? 1 : 0
	end
	println(safe_lines)
end	

part_one()


function might_be_safe(line::Vector{Int64})::Bool
	if is_safe_line(line)
		return true
	end	
	
	for i in 1:length(line)
		cut_line = copy(line)
		deleteat!(cut_line, i)
		if is_safe_line(cut_line)
			return true
		end
	end
	return false
end

function part_two()
	lines = split(read_file("input.txt"), "\n")
	safe_lines = 0
	for line in lines
		safe_lines += might_be_safe(parse_line(line)) ? 1 : 0
	end
	println(safe_lines)
end	

part_two()