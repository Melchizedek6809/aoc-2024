"""
Reads a file and returns its contents as a string.
"""
function read_file(filename::String)::String
	f = open(filename, "r")
	s = read(f, String)
	close(f)
	return s
end

function parse_rules(rules::SubString)::Dict{Int,Set{Int}}
	rules = split(rules, "\n")
	parsed_rules = Dict{Int,Set{Int}}()
	for rule in rules
		parts = split(rule, "|")
		values = parse(Int, parts[1])
		key = parse.(Int, parts[2])
		if !haskey(parsed_rules, key)
			parsed_rules[key] = Set{Int}()
		end
		push!(parsed_rules[key], values)
	end
	return parsed_rules
end

function is_valid(rules::Dict{Int,Set{Int}}, values::Vector{Int})::Bool
	all_vals = Set{Int}()
	for value in values
		push!(all_vals, value)
	end

	vals = Set{Int}()
	for value in values
		if haskey(rules, value)
			current_rules = rules[value]
			for rule in current_rules
				if rule in all_vals && !(rule in vals)
					return false
				end
			end
		end
		push!(vals, value)
	end
	return true
end

function parse_order(rules::Dict{Int,Set{Int}}, order::SubString)::Vector{Vector{Int}}
	order = split(order, "\n")
	filtered_order = []
	for line in order
		values = parse.(Int, split(line, ","))
		if is_valid(rules, values)
			push!(filtered_order, values)
		end
	end
	return filtered_order
end

function ensure_order(rules::Dict{Int,Set{Int}}, values::Vector{Int})::Vector{Int}
	sorted_values = []

	all_vals = Set{Int}()
	for value in values
		push!(all_vals, value)
	end

	vals = Set{Int}()
	for value in values
		if value in vals
			continue
		end

		if haskey(rules, value)
			current_rules = rules[value]
			for rule in current_rules
				if rule in all_vals && !(rule in vals)
					push!(sorted_values, rule)
					push!(vals, rule)
				end
			end
		end
	
		push!(vals, value)
		push!(sorted_values, value)
	end
	return sorted_values
end

function parse_order_or_sort(rules::Dict{Int,Set{Int}}, order::SubString)::Vector{Vector{Int}}
	order = split(order, "\n")
	filtered_order = []
	for line in order
		values = parse.(Int, split(line, ","))
		if is_valid(rules, values)
			continue
		end

		while !is_valid(rules, values)
			values = ensure_order(rules, values)
		end

		push!(filtered_order, values)
	end
	return filtered_order
end


function get_mid_values(filtered_order::Vector{Vector{Int}})::Vector{Int}
	mid_values = []
	for values in filtered_order
		push!(mid_values, values[(length(values) ÷ 2)+1])
	end
	return mid_values
end

function part_one()
	source = read_file("input.txt")
	rules, order = split(source, "\n\n")
	rules = parse_rules(rules)
	filtered_order = parse_order(rules, order)
	mid_values = get_mid_values(filtered_order)
	sum = reduce(+, mid_values)
	println(sum)
end	

part_one()

function part_two()
	source = read_file("input.txt")
	rules, order = split(source, "\n\n")
	rules = parse_rules(rules)
	filtered_order = parse_order_or_sort(rules, order)
	mid_values = get_mid_values(filtered_order)
	sum = reduce(+, mid_values)
	println(sum)
end	

part_two()
