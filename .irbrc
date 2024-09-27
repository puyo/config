IRB.conf[:SAVE_HISTORY] = 10_000

require 'rbconfig'

begin
  require 'pry'
  Pry.start
  exit
rescue LoadError, StandardError => e
  warn e
end
