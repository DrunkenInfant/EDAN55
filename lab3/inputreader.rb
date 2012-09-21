class InputReader
	def self.read(fname)
		vertices = Hash.new
		File.readlines(fname)[1..-1].each { |line|
			if line.strip!.length != 0
				edges = line.scan(/\d+/).map{|i| i.to_i}
				current_id = edges[0]
				edges.delete_if {|x| x == current_id}

				v = vertices[current_id]
				if not v
					v = Vertex.new(current_id)
					vertices[current_id] = v
				end
				
				edges.each { |e|
					neighbour = vertices[e]
					if not neighbour
						neighbour = Vertex.new(e)
						vertices[e] = neighbour
					end
					v.add_neighbour(neighbour)
				}
			end
		}
		return vertices
	end
end