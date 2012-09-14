require 'set'
require './graph.rb'

def max_ind_set(graph)
	#puts "NEW GRAPH"
	puts "new iter, #{graph.size}"
	#puts graph.to_a

	if graph.empty?
		#puts "done"
		return 0
	end
	first = graph.first
	if first.neighbourhood.size == 1
		puts "vi kom hit: #{first}"
		return 1 + max_ind_set(graph - [first])
	end

	u = graph.last
	val1 = 1 + max_ind_set(graph - u.neighbourhood)
	u.neighbourhood.each { |v| graph.add(v) }
	val2 = max_ind_set(graph - [u])
	graph.add(u)
	return [val1, val2].max
end

graph = Graph.new
vertices = []

# Read input
n = File.open(ARGV[0], &:readline).to_i
n.times { |i|
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