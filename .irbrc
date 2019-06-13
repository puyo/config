# http://lucapette.me/pry-everywhere/

IRB.conf[:SAVE_HISTORY] = 10_000

# Use Pry everywhere
begin
  require 'rubygems'
  require 'pry'
  Pry.start
  exit
rescue => e
  puts e
end
