function read_file(filename)
	f = open(filename, "r")
	s = read(f, String)
	close(f)
	return s
end

function parse_line(line)
	cols = split(line, "   ")
	left = parse(Int, cols[1])
	right = parse(Int, cols[2])
	return (left, right)
end

function parse_lines(lines)
	leftList = []
	rightList = []
	for line in lines
		left, right = parse_line(line)
		push!(leftList, left)
		push!(rightList, right)
	end
	sort!(leftList)
	sort!(rightList)
	return (leftList, rightList)
end

function calculate_total(leftList, rightList)
	total = 0
	for i in eachindex(leftList, rightList)
		dist = abs(leftList[i] - rightList[i])
		total += dist
	end
	return total
end

function part_one()
	lines = split(read_file("data.txt"), "\n")
	leftList, rightList = parse_lines(lines)
	total = calculate_total(leftList, rightList)
	println(total)
end

function turn_list_to_map(list)
	map = Dict()
	for i in eachindex(list)
		if !haskey(map, list[i])
			map[list[i]] = 0
		end
		map[list[i]] += 1
	end
	return map
end

function calculate_similarity(leftList, rightMap)
	similarity = 0
	for i in eachindex(leftList)
		if haskey(rightMap, leftList[i])
			similarity += leftList[i] * rightMap[leftList[i]]
		end
	end
	return similarity
end

function part_two()
	lines = split(read_file("data.txt"), "\n")
	leftList, rightList = parse_lines(lines)
	rightMap = turn_list_to_map(rightList)
	similarity = calculate_similarity(leftList, rightMap)
	println(similarity)
end

part_one()
part_two()
