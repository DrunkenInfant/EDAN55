
class Vertex
	attr_accessor :id, :neighbours

	def initialize(id)
		@id = id
		@neighbours = Set.new
	end

	def neighbourhood()
		@neighbours + Set.new(@id)
	end

	def add_neighbour(id)
		@neighbours.add(id)
	end

end

vertices = Set.new
id = 0

# Read input
File.foreach(ARGV[0]) { |line|
	values = line.split(" ")
	if values.size != 1
		v = Vertex.new(id)
		values.each_with_index do |value,index|
			if value == 1
				v.add_neighbour(index)
			end
		end
		vertices.add(v)
		id++
	end
}

puts "hej"