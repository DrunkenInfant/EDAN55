class Vertex
	attr_accessor :id, :neighbours, :visited, :prob

	def initialize(id)
		@id = id
		@neighbours = []
		@visited = 0
	end

	def add_neighbour(v)
		@neighbours << (v)
	end

	def to_s()
		"#{@id} (#{prob*100.0}%)"
	end
end
