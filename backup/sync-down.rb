#!/usr/bin/env ruby

require 'shellwords'

cmd = [
  'aws', 's3', 'sync',
  's3://puyofiles/',
  './',
  '--profile', 'puyo',
  '--exclude', 'photos/*',
  *ARGV
]

puts cmd.shelljoin
system(*cmd)
