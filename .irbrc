IRB.conf[:SAVE_HISTORY] = 10_000

begin
  require 'pry'
  Pry.start
  exit
rescue => e
  warn e
end
