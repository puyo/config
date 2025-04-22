#!/usr/bin/env ruby

require 'shellwords'

host = ARGV[0]
if host.nil?
  warn 'Must pass host name as first argument'
  exit 1
end

if Process.uid != 0
  exec("sudo #{$0} #{ARGV.shelljoin}")
end

begin
  puts "\e[33mFormatting...\e[0m"
  system("alejandra .")
  puts "\e[33mCopying config files into place...\e[0m"
  system("rsync -rvap ./ /etc/nixos/ --exclude '*.rb'") or next
  puts "\e[33mRebuilding #{host}...\e[0m"
  system("nixos-rebuild switch --flake /etc/nixos/##{host}") or next
  puts "\e[32mSuccess\e[0m"
  puts
  puts "Press Enter to rebuild host #{host}"
end while $stdin.gets
