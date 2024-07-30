#!/usr/bin/env ruby

require 'rubygems'
require 'isna'

def pretty_output(title, string)
  prefix = '   |'.to_ansi.red.to_s
  puts "#{prefix}#{title}:".to_ansi.yellow.to_s
  puts prefix + ('-' * 76).to_ansi.cyan.to_s
  count = 0
  string.each_line do |line|
    count += 1
    puts "#{prefix}#{count.to_s.rjust(6).to_ansi.cyan.to_s}| #{line.chomp}"
  end
  puts ''
end

Dir.glob(File.join(File.dirname(__FILE__), '*', 'test.rb')).each do |file|
  output = `ruby #{file}`
  expected = File.read(File.dirname(file) + '/expected.txt')
  if output == expected
    puts 'OKAY '.to_ansi.green.to_s + " #{file}"
    next
  end
  puts ''
  puts ''
  puts 'FAILED'.to_ansi.red.to_s + " #{file}"
  puts ''
  puts ''
  pretty_output('Expected', expected)
  pretty_output('Got', output)
  pretty_output('Code', File.read(file))
  puts ''
end

