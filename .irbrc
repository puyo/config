IRB.conf[:SAVE_HISTORY] = 10_000

require 'rbconfig'

begin
  require 'pry'
rescue LoadError, StandardError => e
  warn e
end
