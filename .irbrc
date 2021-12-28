IRB.conf[:SAVE_HISTORY] = 10_000

require 'rbconfig'

if Gem::Version.new(RbConfig::CONFIG['ruby_version']) < Gem::Version.new('3.0.0')
  begin
    require 'pry'
    Pry.start
    exit
  rescue => e
    warn e
  end
end
