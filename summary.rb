#! /usr/bin/env ruby
#

command = ARGV[0]
exclude = ['figures', 'figures-dia', 'figures-source', 'couchapp', 'latex', 'pdf', 'epub', 'en']

data = []
Dir.glob("*").each do |dir|
  if !File.file?(dir) && !exclude.include?(dir)
    lines = `git diff-tree -r -p master:en master:#{dir} | grep '^+' | wc -l`.strip.to_i
    last_commit = `git log -1 --no-merges --format="%ar" #{dir}`.chomp
    authors = ""
    if command == 'authors'
      authors = `git shortlog --no-merges -s -n #{dir}`.chomp
    end
    data << [dir, lines, authors, last_commit]
  end
end

d = data.sort { |a, b| b[1] <=> a[1] }
d.each do |dir, lines, authors, last|
  puts "#{dir.ljust(10)} - #{lines} (#{last})"
  if command == 'authors'
    puts "Authors: #{authors.split("\n").size}"
    puts authors 
    puts
  end
end
