require './directed_multigraph.rb'
require './inputreader.rb'

def simulate(vertices, alpha, iterations)
	current_vertex = vertices.values.sample
	iterations.times {
		current_vertex.visited += 1
		if rand() <= alpha
			current_vertex = current_vertex.neighbours.sample
			if not current_vertex
				current_vertex = vertices.values.sample
			end
		else
			current_vertex = vertices.values.sample
		end
	}
	vertices.values.sort {|v1,v2| v1.id <=> v2.id }.map{ |v| v.visited.to_f/iterations}
end
