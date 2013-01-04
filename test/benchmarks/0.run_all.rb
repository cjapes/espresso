#!/usr/bin/env ruby


class BenchmarkRunner
  attr_accessor :rvm_handler
  def rvm_handler
    @rvm_handler||= RvmHandler.new
  end

  def current_dir
    File.dirname(__FILE__)
  end

  def benchmark_files
    @files ||= Dir["#{current_dir}/*_benchmark.rb"]
  end

  def rubies
    %w[ree-1.8.7-2012.02  ruby-1.9.3-p327-turbo]
  end

  def run_file(f)
    puts f
    puts "-" * 80
    puts `ruby #{f}`
    puts "-" * 80
    puts
  end

  def run_suite
    puts rvm_handler.current_ruby
    benchmark_files.each do |f|
      run_file(f)
    end
  end
end

class RvmHandler
  def current_ruby
    shell("rvm info|head -n 2")
  end

  def shell(cmd)
    IO.popen(cmd) { |f| puts f.gets }
  end
end
BenchmarkRunner.new.run_suite