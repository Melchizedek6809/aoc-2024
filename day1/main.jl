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
	cols = split(line, "   ")
	left = parse(Int64, cols[1])
	right = parse(Int64, cols[2])
	return (left, right)
end


"""
Parses a list of lines into two sorted lists of integers.
"""
function parse_lines(lines::Vector{SubString{String}})
	leftList::Vector{Int64} = []
	rightList::Vector{Int64} = []
	for line in lines
		left, right = parse_line(line)
		push!(leftList, left)
		push!(rightList, right)
	end
	sort!(leftList)
	sort!(rightList)
	return (leftList, rightList)
end


"""
Calculates the total distance between two lists of integers.
"""
function calculate_total(leftList::Vector{Int64}, rightList::Vector{Int64})::Int64
	total::Int64 = 0
	for i in eachindex(leftList, rightList)
		dist = abs(leftList[i] - rightList[i])
		total += dist
	end
	return total
end


"""
Calculates the total distance between two lists of integers and prints it.
"""
function part_one(leftList::Vector{Int64}, rightList::Vector{Int64})
	total = calculate_total(leftList, rightList)
	println(total)
end




"""
Turns a list of integers into a map of integers to their counts.
"""
function turn_list_to_map(list::Vector{Int64})::Dict{Int64, Int64}
	map::Dict{Int64, Int64} = Dict()
	for i in eachindex(list)
		if !haskey(map, list[i])
			map[list[i]] = 0
		end
		map[list[i]] += 1
	end
	return map
end


"""
Calculates the similarity between a list of integers and a map of integers to their counts.
"""
function calculate_similarity(leftList::Vector{Int64}, rightMap::Dict{Int64, Int64})::Int64
	similarity::Int64 = 0
	for i in eachindex(leftList)
		if haskey(rightMap, leftList[i])
			similarity += leftList[i] * rightMap[leftList[i]]
		end
	end
	return similarity
end


"""
Calculates the similarity between a list of integers and a map of integers to their counts and prints it.
"""
function part_two(leftList::Vector{Int64}, rightList::Vector{Int64})
	rightMap = turn_list_to_map(rightList)
	similarity = calculate_similarity(leftList, rightMap)
	println(similarity)
end


lines = split(read_file("data.txt"), "\n")
leftList, rightList = parse_lines(lines)
part_one(leftList, rightList)
part_two(leftList, rightList)
