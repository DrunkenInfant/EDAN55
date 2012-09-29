require 'set'
require 'algorithms'

class Collatz
	def initialize(current)
		@current = current
	end

	def has_next?
		return @current != 0
	end

	def next()
		tmp = @current
		if @current == 1
			@current = 0
		elsif @current.even?
			@current /= 2
		else
			@current = @current * 3 + 1
		end
		return tmp
	end
end


def alg1()
	max = 0
	distinct = Set.new
	iterations = 0
	ARGV[0].to_i.times{ |i|
		coll = Collatz.new(i+1)
		while coll.has_next?
			num = coll.next
			if num > max
				max = num
			end
			distinct.add(num)
			iterations += 1
		end
	}
	puts "Maximum value amongst numbers: #{max}"
	puts "Number of distinct numbers: #{distinct.size}"
	puts "Length of sequence: #{iterations}"
end

def alg2()
	max = 0
	ARGV[0].to_i.times{ |i|
		coll = Collatz.new(i+1)
		while coll.has_next?
			num = coll.next
			if num > max
				max = num
			end
		end
	}
	puts "Maximum value amongst numbers: #{max}"
end

def alg2a()
	max = 0
	ARGV[0].to_i.times{ |i|
		coll = Collatz.new(i+1)
		while coll.has_next?
			num = coll.next
			if num > max
				max = num
			end
		end
	}
	puts "Maximum value amongst numbers: #{max}"
end

MAX_NUMBER = 100140889442062814140434711571

class UniversalHash

	def initialize()
		@a = Random.rand(1..MAX_NUMBER)
		@b = Random.rand(1..MAX_NUMBER)
	end

	def hash(x)
		return ((@a * x + @b) % MAX_NUMBER)
	end
end

MAX_STORAGE = 1024
def alg3(seq)
	h = UniversalHash.new
	heap = Containers::MaxHeap.new

	seq.times{ |i|
		coll = Collatz.new(i+1)
		while coll.has_next?
			x = coll.next
			xh = h.hash(x)
			if heap.size < MAX_STORAGE and not heap.has_key? xh
				heap.push(xh)
			elsif not heap.has_key? xh and xh < heap.max
				heap.max!
				heap.push(xh)
			end
		end
	}
	return ([MAX_STORAGE, heap.size].min*MAX_NUMBER)/heap.max
end
sequences = Hash.new
sequences[10] = 22
sequences[100] = 251
sequences[1000] = 2228
sequences[10000] = 21664
sequences[100000] = 217212
sequences[1000000] = 2168611 

sequences.each_pair { |seq, cor|
	err = 1
	while err > 1/Math.sqrt(MAX_STORAGE)
		q = alg3(seq)
		err = (q - cor).abs.to_f/cor
	end
	puts "#{q}\t#{err}"
}
