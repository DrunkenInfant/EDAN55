require './r0.rb'
require './r1.rb'
require './r2.rb'

$next_vertex_id = 1
$recursions = 0

start = Time.now
graph = InputReader.read(ARGV[1])

if ARGV[0] == "r0"
	puts "Maximum Independent Set: #{r0(graph)}"
elsif ARGV[0] == "r1"
	puts "Maximum Independent Set: #{r1(graph)}"
elsif ARGV[0] == "r2"
	puts "Maximum Independent Set: #{r2(graph)}"
else
	abort("Invalid algorithm => r0, r1 or r2")
end

stop = Time.now
puts "Time: #{stop - start}s"
puts "Recursions: #{$recursions}"