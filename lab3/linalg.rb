require 'set'
class SparseMatrix

	def initialize()
		@columns = Hash.new
		#@triples = []
		@triples = Array.new
	end

	def [](i, j)
		if includes? i, j
			return @columns[j][i].value
		end
		return 0
	end

	def []=(i, j, value)
		t = Tripple.new(i, j, value)
		if not @columns.has_key? j
			@columns[j] = Hash.new
		end
		if @columns[j].has_key? i
			@columns[j][i].value = value
		else
			@columns[j][i] = t
			@triples << t
		end
	end

	def includes?(i, j)
		@columns.has_key? j and @columns[j].has_key? i
	end

	def multiply_from_left(vector, alpha)
		product = Array.new(vector.size, 0)
		@triples.each { |trp|
			product[trp.j] += vector[trp.i] * trp.value * alpha
		}
		return product
	end

	def size()
		@triples.size
	end

	def to_s
		l = []
		@columns.each_value {|col|
			col.each_value {|trp|
				l << trp
			}
		}
		l.to_s
	end
end

class Tripple
	attr_accessor :i, :j, :value

	def initialize(i, j, value)
		@i = i
		@j = j
		@value = value
	end

	def to_s
		"(#{@i}, #{@j}) -> #{@value}"
	end
end

def create_prob(vertices, alpha)
	rand_prob = (1 - alpha)/vertices.size
	prob_a = Array.new(vertices.size) { |i|
		v = vertices[i]
		if not v.neighbours.empty?
			adj = Array.new(vertices.size, rand_prob)
			part = alpha/v.neighbours.size
			v.neighbours.each { |n|
				adj[n.id] += part
			}
		else
			part = alpha/vertices.size + rand_prob
			adj = Array.new(vertices.size, part)
		end
		adj
	}
	return Matrix.rows(prob_a, false)
end

def pagerank_linalg(alpha, p, prob, r)
	n = Math.log2(r).round()
	n.times { prob *= prob }
	return (p * prob).row_vectors[0].to_a
end

def create_sparse_prob(vertices)
	h = SparseMatrix.new
	vertices.each_value { |v|
		if not v.neighbours.empty?
			nscale = 1.0/v.neighbours.size
			v.neighbours.each { |n|
				h[v.id, n.id] += nscale
			}
		end
	}
	return h
end

def create_d_matrix(vertices)
	d = Set.new
	vertices.each_value { |v|
		if v.neighbours.empty?
			d.add(v.id)
		end
	}
	return d
end

def pagerank_linalg_sparse(alpha, p, h, d, n, r)
	scale = (1 - alpha)/n
	norm = 0
	norm_last = 1
	iters = 0
	r.times {
		iters += 1
		ph = h.multiply_from_left(p, alpha)
		pd = multiply_d_matrix(p, d, alpha, n)
		p1 = multiply_ones_matrix(p, scale)
		p = Array.new(n) { |i|
			sum = ph[i] + pd[i] + p1[i]
			norm += sum * sum
			sum
		}
		norm = Math.sqrt(norm)
		if (norm - norm_last).abs <= 0.005
			puts "iterations: #{iters}"
			return p
		end
		norm_last = norm
	}
	return p
end

def multiply_d_matrix(p, d, alpha, n)
	sum = 0
	p.each_with_index { |v, i|
		if d.include? i
			sum += v
		end
	}
	return Array.new(n, sum*alpha/n)
end


def multiply_ones_matrix(p, scale)
	sum = p.inject { |s,v| s += v }
	return Array.new(p.size, sum * scale)
end

