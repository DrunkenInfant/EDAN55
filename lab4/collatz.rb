
class Collatz

	def initialize(current)
		@current = current
	end

	def next()
		tmp  = @current
		if @current.even?
			@current /= 2
		else
			@current = @current * 3 + 1
		end
		return tmp
	end
end

coll = Collatz.new(10)
num = coll.next
while num > 1
	puts num
	num = coll.next
end
