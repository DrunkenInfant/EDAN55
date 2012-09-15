require 'set'
require './graph.rb'

def max_ind_set(graph)
	if graph.empty?
		#puts "done"
		return 0
	end
	first = graph.first
	if first.neighbourhood.size == 1
		#puts "vi kom hit: #{first}"
		val = 1 + max_ind_set(graph - [first])
		graph.restore(Set.new([first]))
		return val
	end

	u = graph.last
	#puts "selecting: #{u}"
	val1 = 1 + max_ind_set(graph - u.neighbourhood)

	graph.restore(u.neighbourhood)
	val2 = max_ind_set(graph - Set.new([u]))
	graph.restore(Set.new([u]))
	return [val1, val2].max
end

graph = Graph.new
vertices = []

# Read input
File.open(ARGV[0], &:readline).to_i.times { |i|
	vertices.push(Vertex.new(i))
}

File.readlines(ARGV[0])[1..-1].each_with_index { |line,i|
	values = line.split(" ")

	v = vertices[i]
	values.each_with_index do |value,j|
		if value == "1"
			v.add_neighbour(vertices[j])
		end
	end
	graph.add(v)
}

#puts graph - vertices[23].neighbourhood

puts max_ind_set(graph)