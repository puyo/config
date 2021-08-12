#!/usr/bin/env ruby

require 'open3'

RE = /^Event 'new' on sink #(\d+)$/

puts "Listening for new sinks"

Open3.popen2('pactl', 'subscribe') do |_stdin, stdout, _status_thread|
  stdout.each_line do |line|
    match = RE.match(line)
    system('pactl', 'set-default-sink', match.captures.first) if match
  end
end
