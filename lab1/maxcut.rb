require 'set'

class Edge
	attr_accessor :v1, :v2, :weight
	def initialize(v1, v2, weight)
		@v1 = v1
		@v2 = v2
		@weight = weight
	end

	def between?(set1, set2)
		(set1.include? @v1 and set2.include? @v2) or (set2.include? @v1 and set1.include? @v2)
	end
end

vertices = Set.new
edges = Set.new
File.foreach(ARGV[0]){ |line|
	values = line.split(' ')
	if values.size == 3
		v1 = values[0].to_i
		v2 = values[1].to_i
		vertices.add(v1)
		vertices.add(v2)
		edges.add(Edge.new(v1, v2, values[2].to_i))
	end
}
results = []
100.times do
	# Construct the set of selected verticies
	v_a = Set.new
	vertices.each{ |v|
		# Select by randomly decide for each vertex
		if [true,false].sample
			v_a.add(v)
		end
	}
	# Construct a set of the verticies not selected
	v_b = vertices - v_a
	# Contruct the set of edges constituting the cut
	cut = Set.new
	edges.each { |e|
		if e.between?(v_a, v_b)
			cut.add(e)
		end
	}
	# Calculate the total weight of the cut
	total_weight = 0
	cut.each { |e|
		total_weight += e.weight
	}
	results.push(total_weight)
end
puts results
avg = results.inject { |sum, res| sum += res } / results.size
puts "Average: #{avg}"
