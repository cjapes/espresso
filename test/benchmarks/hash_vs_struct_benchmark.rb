# how much slower is Stuct compared to Hash?
require 'benchmark'
Example = Struct.new("Example", :value)

struct = Example.new
hash = {}
value = "The value"

n = 5000000
Benchmark.bm(10) do |m|
  # test assignment and access for Hash and Struct
  m.report("Hash") { n.times do; hash[:value] = value; end }
  m.report("Struct") { n.times do; struct.value = value; end }
end

# ruby-1.9.3-p327-turbo
#     user     system      total        real
# 0.640000   0.000000   0.640000 (  0.643438)
# 0.700000   0.000000   0.700000 (  0.700785)

# ree-1.8.7-2012.02
#     user     system      total        real
# 0.880000   0.000000   0.880000 (  0.876315)
# 1.430000   0.000000   1.430000 (  1.430184)
