require 'set'
require './graph.rb'
require './inputreader.rb'

def r2(graph)
	$recursions += 1
	if graph.empty?
		return 0
	end

	if graph.has_neighbourhood(3)
		v = graph.get_vertex_by_neighbourhood_size(3)
		ne = v.neighbours.to_a
		if ne.first.neighbourhood.include? ne.last
			val = 1 + r2(graph - v.neighbourhood)
			graph.restore(v.neighbourhood)
			return val
		else
			z = Vertex.new($next_vertex_id)
			$next_vertex_id += 1
			ne.first.neighbourhood.each { |n|
				if not n == ne.first and not n == v
					z.add_neighbour(n)
				end
			}
			ne.last.neighbourhood.each { |n|
				if not n == ne.last and not n == v
					z.add_neighbour(n)
				end
			}
			val = 1 + r2(graph - v.neighbourhood + z)
			(graph - [z]).restore(v.neighbourhood)
			return val
		end
	end
	
	if graph.has_neighbourhood(2)
		v = graph.get_vertex_by_neighbourhood_size(2)
		val = 1 + r2(graph - v.neighbourhood)
		graph.restore(v.neighbourhood)
		return val
	end

	if graph.has_neighbourhood(1)
		first = graph.first
		val = 1 + r2(graph - [first])
		graph.restore([first])
		return val
	end

	u = graph.last
	val1 = 1 + r2(graph - u.neighbourhood)
	graph.restore(u.neighbourhood)

	val2 = r2(graph - [u])
	graph.restore([u])
	return [val1, val2].max
end