class Vertex
	attr_accessor :id, :neighbours, :visited

	def initialize(id)
		@id = id
		@neighbours = []
		@visited = 0
	end

	def add_neighbour(v)
		@neighbours << (v)
	end
end