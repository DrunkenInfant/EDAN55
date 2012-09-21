require 'matrix'
require './linalg.rb'

class Vertex
	attr_accessor :id, :neighbours

	def initialize(id)
		@id = id
		@neighbours = []
	end

	def add_neighbour(n)
		@neighbours << n
	end
end

vertices = Hash.new
v0 = Vertex.new(0)
v1 = Vertex.new(1)
v2 = Vertex.new(2)
v3 = Vertex.new(3)
v0.add_neighbour(v1)
v0.add_neighbour(v3)
v1.add_neighbour(v0)
v1.add_neighbour(v3)
v1.add_neighbour(v3)
v2.add_neighbour(v1)
v3.add_neighbour(v2)
vertices[0] = v0
vertices[1] = v1
vertices[2] = v2
vertices[3] = v3
prob = create_prob(vertices, 0.85)
#prob.row_vectors.each() {|row|
	#puts row.inject {|sum,x| sum += x}
#}
p = Matrix[Array.new(vertices.size){|i| 
	if i == 0
		1
	else
		0
	end}]
r = ARGV[0].to_i
puts pagerank_linalg(0.85, p, prob, r)
