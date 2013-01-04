require 'benchmark'
a = ('a'..'z').to_a
b = a + a
n = 5000000
Benchmark.bm do |m|
  # test assignment and access for Hash and Struct
  m.report { n.times do; b.dup ; end }
  m.report { n.times do; Array.new(b); end }
end
# ruby-1.9.3-p327-turbo
#     user     system      total        real
# 1.400000   0.010000   1.410000 (  1.411030)
# 1.200000   0.000000   1.200000 (  1.196114)


# ree-1.8.7-2012.02
#     user     system      total        real
# 1.500000   0.010000   1.510000 (  1.510398)
# 1.730000   0.000000   1.730000 (  1.731139)
