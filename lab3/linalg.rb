
def create_prob(vertices, alpha)
	prob_a = []
	rand_prob = (1 - alpha)/vertices.size
	vertices.each_value { |v|
		prob_a[v.id] = Array.new(vertices.size) {|i| 0.to_f}
		v.neighbours.each { |n|
			prob_a[v.id][n.id] += alpha/v.neighbours.size
		}
	}
	Matrix.rows(prob_a, false) + Matrix.rows(\
		Array.new(vertices.size){ |i| Array.new(vertices.size) {|j| rand_prob } })
			
end

def pagerank_linalg(alpha, p, prob, r)
	n = Math.log2(r).round()
	n.times {
		prob *= prob
	}
	p*prob
end

