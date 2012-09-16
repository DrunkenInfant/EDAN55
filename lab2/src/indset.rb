require 'set'
require './graph.rb'
$times = 0
$next_vertex_id = 1
def max_ind_set(graph)
	$times += 1
	if graph.empty?
		$bottom += 1
		return 0
	end
	
	if graph.has_neighbourhood(1)
		first = graph.first
		val = 1 + max_ind_set(graph - [first])
		graph.restore([first])
		return val
	end

	u = graph.last
	val1 = 1 + max_ind_set(graph - u.neighbourhood)
	graph.restore(u.neighbourhood)

	val2 = max_ind_set(graph - [u])
	graph.restore([u])
	return [val1, val2].max
end

def max_ind_set1(graph)
	$times += 1
	if graph.empty?
		$bottom += 1
		return 0
	end
	
	if graph.has_neighbourhood(2)
		v = graph.get_vertex_by_neighbourhood_size(2)
		val = 1 + max_ind_set1(graph - v.neighbourhood)
		graph.restore(v.neighbourhood)
		return val
	end

	if graph.has_neighbourhood(1)
		first = graph.first
		val = 1 + max_ind_set1(graph - [first])
		graph.restore([first])
		return val
	end

	u = graph.last
	val1 = 1 + max_ind_set1(graph - u.neighbourhood)
	graph.restore(u.neighbourhood)

	val2 = max_ind_set1(graph - [u])
	graph.restore([u])
	return [val1, val2].max
end

def max_ind_set2(graph)
	$times += 1
	if graph.empty?
		return 0
	end

	if graph.has_neighbourhood(3)
		v = graph.get_vertex_by_neighbourhood_size(3)
		ne = v.neighbours.to_a
		if ne.first.neighbourhood.include? ne.last
			val = 1 + max_ind_set2(graph - v.neighbourhood)
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
			val = 1 + max_ind_set2(graph - v.neighbourhood + z)
			(graph - [z]).restore(v.neighbourhood)
			return val
		end
	end
	
	if graph.has_neighbourhood(2)
		v = graph.get_vertex_by_neighbourhood_size(2)
		val = 1 + max_ind_set2(graph - v.neighbourhood)
		graph.restore(v.neighbourhood)
		return val
	end

	if graph.has_neighbourhood(1)
		first = graph.first
		val = 1 + max_ind_set2(graph - [first])
		graph.restore([first])
		return val
	end

	u = graph.last
	val1 = 1 + max_ind_set2(graph - u.neighbourhood)
	graph.restore(u.neighbourhood)

	val2 = max_ind_set2(graph - [u])
	graph.restore([u])
	return [val1, val2].max
end

graph = Graph.new
vertices = []

# Read input
File.open(ARGV[0], &:readline).to_i.times { |i|
	vertices.push(Vertex.new(i))
	$next_vertex_id += 1
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

start = Time.now
puts max_ind_set2(graph)
stop = Time.now
puts "Time: #{stop - start}"
puts "Recursions: #{$times}"
