require 'set'

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

alg2()
