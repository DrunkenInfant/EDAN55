require 'matrix'
require './linalg.rb'
require './directed_multigraph.rb'
require './inputreader.rb'
require './simulation.rb'

# Usage:
# pagerank.rb type file interations

type = ARGV[0]
vertices = InputReader.read(ARGV[1])
iterations = ARGV[2].to_i
alpha = 0.85
result = []
case type
when "sim"
	result = simulate(vertices, alpha, iterations)
when "linalg"
	prob = create_prob(vertices, alpha)
	p = Matrix[Array.new(vertices.size, 1.0/vertices.size)]
	result = pagerank_linalg(alpha, p, prob, iterations)
when "sparse"
	h = create_sparse_prob(vertices)
	puts h.size
	d = create_d_matrix(vertices)
	p = Array.new(vertices.size, 1.0/vertices.size)
	puts "setup done"
	result = pagerank_linalg_sparse(alpha, p, h, d, vertices.size, iterations)
when "data"
	prob = create_prob(vertices, alpha)
	puts prob
	prob2 = prob
	10.times {
		prob2 *= prob
	}
	puts prob2
	h = create_sparse_prob(vertices)
	puts h
	d = create_d_matrix(vertices)
	puts d
else
	puts "choose from: sim, linalg, sparse"
end

result.each_with_index {|v,i|
	vertices[i].prob = v
}
puts vertices.values.sort { |a,b| b.prob <=> a.prob }[0..9]
#puts "Sum: #{result.inject {|sum,v| sum += v }}"
