#!/usr/bin/env ruby

require 'shellwords'

cmd = [
  'aws', 's3', 'sync',
  './',
  's3://puyofiles/',
  '--profile', 'puyo',
  '--exclude', '*/.DS_Store',
  '--exclude', 'photos/*',
  '--delete',
]

pre_cmd = cmd + ['--dryrun']

puts pre_cmd.shelljoin
system(*pre_cmd)

puts cmd.shelljoin
print "OK? y/n "
if $stdin.gets.strip == 'y'
  system(*cmd)
end
