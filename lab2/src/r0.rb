require 'set'
require '../../lib/graph.rb'
require './inputreader.rb'

def r0(graph)
	$recursions += 1
	if graph.empty?
		return 0
	end
	
	if graph.has_neighbourhood(1)
		first = graph.first
		val = 1 + r0(graph - [first])
		graph.restore([first])
		return val
	end

	u = graph.last
	val1 = 1 + r0(graph - u.neighbourhood)
	graph.restore(u.neighbourhood)

	val2 = r0(graph - [u])
	graph.restore([u])
	return [val1, val2].max
end