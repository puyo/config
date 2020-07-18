#!/usr/bin/env ruby

require 'shellwords'

cmd = [
  'aws', 's3', 'sync',
  './',
  's3://puyofiles/',
  '--profile', 'puyo',
  '--exclude', 'photos/*',
  '--delete',
  *ARGV
]

puts cmd.shelljoin
print "OK? y/n "
if $stdin.gets.strip == 'y'
  system(*cmd)
end
