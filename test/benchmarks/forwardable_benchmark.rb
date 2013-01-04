# should you define your delegations manually or rather use the Forwardable module + def_delegator?
require 'benchmark'
require 'forwardable'

class Receiver
  def some_method(*args)
    (1..20).to_a # work
  end
end

class Subject
  attr_accessor :receiver
  extend Forwardable
  def_delegator :@receiver, :some_method

  def initialize
    @receiver = Receiver.new
  end

  def plain_some_method(*args)
    @receiver.some_method(*args)
  end
end

@subject = Subject.new
n = 500000
Benchmark.bm(10) do |x|
  x.report("plain:")   { for i in 1..n; @subject.plain_some_method(nil); end }
  x.report("delegator:") { for i in 1..n; @subject.some_method(nil); end }
end

# ruby-1.9.3-p327-turbo
#                  user     system      total        real
# plain:       0.790000   0.030000   0.820000 (  0.808321)
# delegator:   0.770000   0.010000   0.780000 (  0.781279)


# ree-1.8.7-2012.02
#                 user     system      total        real
# plain:      1.510000   0.060000   1.570000 (  1.578078)
# delegator:  1.820000   0.070000   1.890000 (  1.880947)


## We see something very interesting here: in ruby 1.9.3 delegation is actually faster, than
## plain code! ))