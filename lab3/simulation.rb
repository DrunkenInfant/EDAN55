require './directed_multigraph.rb'
require './inputreader.rb'

vertices = InputReader.read(ARGV[0])	
iterations = ARGV[1].to_i

current_vertex = vertices.values.sample
iterations.times {
	current_vertex.visited += 1
	if rand() <= 0.85
		current_vertex = current_vertex.neighbours.sample
		if not current_vertex
			current_vertex = vertices.values.sample
		end
	else
		current_vertex = vertices.values.sample
	end
}

vertices.values.each { |v|
	puts "Vertex #{v.id} visited #{v.visited} times => frequency #{v.visited.to_f/iterations}"
}
