#!/usr/bin/env ruby

dir = File.dirname(__FILE__)
files = Dir["#{dir}/*_benchmark.rb"]

files.each do |f|
  a = `ruby #{f}`
  puts f
  puts "-" * 80
  puts a
  puts "-" * 80
end