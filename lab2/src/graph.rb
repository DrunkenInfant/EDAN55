class Graph

	def initialize()
		@slist = Hash.new
	end

	def add(v)
		if not @slist[v.neighbourhood.size]
			@slist[v.neighbourhood.size] = Set.new([v])
		else
			@slist[v.neighbourhood.size].add(v)
		end
	end

	def -(vset)
		removed = Set.new
		vset.each { |v|
			if @slist[v.neighbourhood.size]
				@slist[v.neighbourhood.size].delete(v)
				if @slist[v.neighbourhood.size].empty?
					@slist.delete(v.neighbourhood.size)
				end
			end
		}
		self
	end

	def first
		@slist[@slist.keys.min].to_a.first
	end

	def last
		@slist[@slist.keys.max].to_a.last
	end

	def empty?
		@slist.empty?
	end

	def size
		self.to_a.size
	end

	def to_a
		vertecies = []
		@slist.each { |key, set|
			vertecies.concat(set.to_a)
		}
		vertecies
	end

	def to_s
		
		self.to_a.to_s
	end

end

class Vertex
	attr_accessor :id, :neighbours

	def initialize(id)
		@id = id
		@neighbours = []
		@neighbours << self
	end

	def neighbourhood()
		@neighbours
	end

	def add_neighbour(v)
		@neighbours << v
		self
	end

	def <=>(other)
		@neighbours.size - other.neighbours.size
	end

	def hash
		@id.hash
	end

	def eql?(other)
		@id == other.id
	end

	def to_s
		neighbours_id = []
		@neighbours.each { |n|
			neighbours_id << n.id
		}
		"#{id}:#{neighbours_id.to_s}"
	end
end