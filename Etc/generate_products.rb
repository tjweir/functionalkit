require 'erb'
require 'fileutils'

def make_p n, out_dir
  varnames = ('_1'..'_9').to_a[0,n] # needed for template.
  write = proc { |ext, n|
    File.open("#{out_dir}/FKP#{n}.#{ext}", 'w') do |f| 
      f.puts ERB.new(IO.read("FKPx.#{ext}.erb")).result(binding)
    end
  }

  write['h', n]
  write['m', n]
end

output_dir = File.join(File.dirname(__FILE__), 'output')
originals_dir = File.join(File.dirname(__FILE__), 'Originals')
FileUtils::mkdir_p output_dir

(1..8).to_a.each do |n| 
  make_p n, output_dir
end

exit_code = 0
Dir.entries('output').select { |d| d !~ /^(\.)+$/ }.select { |bf| File.exist?(File.join(originals_dir, bf)) }.each { |bf|
  diff = `diff #{File.join(originals_dir, bf).inspect} #{File.join(output_dir, bf).inspect}`
  if (!diff.empty?) then
    puts "[#{bf}] diff:\n#{diff.split("\n").map { |l| "  " + l }.join("\n")}"
    exit_code = 1
  end
}
(exit_code == 0) ? puts("Generation complete.") : puts("Generation complete, but products were different to originals.")
exit(exit_code)
