require 'erb'

n = ARGV.shift.to_i
f = ARGV.shift

varnames = ('_1'..'_9').to_a[0,n]

template = ERB.new(IO.read("FKPx.#{f}.erb"))

puts template.result(binding)
