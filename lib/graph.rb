require 'Set'

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

	def delete(v)
		@slist[v.neighbourhood.size].delete(v)
		if @slist[v.neighbourhood.size].empty?
			@slist.delete(v.neighbourhood.size)
		end
	end

	def -(vset)
		vset.each { |v|
			delete(v)
			v.neighbours.each { |n|
				if not vset.include? n
					delete(n)
					n.remove_neighbour(v)
					add(n)
				end
			}
		}
		self
	end

	def +(v)
		v.neighbours.each { |n|
			delete(n)
			n.add_neighbour(v)
			add(n)
		}
		add(v)
		self
	end

	def restore(vset)
		vset.each { |v|
			v.neighbours.each { |n|
				if include? n
					delete(n)
					n.add_neighbour(v)
					add(n)
				end
			}
			add(v)
		}
	end

	def include?(v)
		@slist.has_key?(v.neighbourhood.size) and\
		 @slist[v.neighbourhood.size].include? v
	end

	def has_neighbourhood(size)
		@slist.has_key? size
	end

	def get_vertex_by_neighbourhood_size(size)
		@slist[size].first
	end

	def first
		@slist[@slist.keys.min].first
	end

	def last
		@slist[@slist.keys.max].first
	end

	def empty?
		@slist.empty?
	end
end

class Vertex
	attr_accessor :id, :neighbourhood, :neighbours

	def initialize(id)
		@id = id
		@neighbours = Set.new
		@neighbourhood = Set.new
		@neighbourhood << self
	end

	def add_neighbour(v)
		@neighbourhood << v
		@neighbours << v
		self
	end

	def remove_neighbour(n)
		@neighbourhood.delete(n)
		@neighbours.delete(n)
	end

	def <=>(other)
		@neighbourhood.size - other.neighbourhood.size
	end

	def hash
		@id.hash
	end

	def eql?(other)
		@id == other.id
	end
end