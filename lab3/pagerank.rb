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
	p = Matrix[Array.new(vertices.size){|i| 
		if i == 0
			1
		else
			0
		end
	}]
	result = pagerank_linalg(alpha, p, prob, iterations)
when "sparse"
	puts "Not implemented"
else
	puts "choose from: sim, linalg, sparse"
end

puts result
