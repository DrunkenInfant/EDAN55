require 'set'
require '../../lib/graph.rb'

class InputReader
	def self.read(fname)
		graph = Graph.new
		vertices = []

		File.open(fname, &:readline).to_i.times { |i|
			vertices.push(Vertex.new(i))
			$next_vertex_id += 1
		}

		File.readlines(fname)[1..-1].each_with_index { |line,i|
			values = line.split(" ")

			v = vertices[i]
			values.each_with_index do |value,j|
				if value == "1"
					v.add_neighbour(vertices[j])
				end
			end
			graph.add(v)
		}
		return graph
	end
end