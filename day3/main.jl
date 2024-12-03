"""
Reads a file and returns its contents as a string.
"""
function read_file(filename::String)::String
	f = open(filename, "r")
	s = read(f, String)
	close(f)
	return s
end


function part_one()
	source = read_file("input.txt")
	regex = r"mul\(([0-9]+),([0-9]+)\)"
	sum = 0;
	for match in eachmatch(regex, source)
		a = parse(Int64, match.captures[1])
		b = parse(Int64, match.captures[2])
		sum += a * b
	end
	println(sum)
end	

part_one()

function part_two()
	source = read_file("input.txt")
	sum = 0
	doNow = true
	for i in 1:length(source)
		if doNow
			m = match(r"^mul\(([0-9]+),([0-9]+)\)", source[i:end])
			if m != nothing
				a = parse(Int64, m.captures[1])
				b = parse(Int64, m.captures[2])
				sum += a * b
			end
		end
		if match(r"^do\(\)", source[i:end]) != nothing
			doNow = true;
		end
		if match(r"^don't\(\)", source[i:end]) != nothing
			doNow = false;
		end
	end
	println(sum)
end	

part_two()
