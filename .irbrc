# vim:filetype=ruby:

require 'irb/completion'
require 'irb/ext/save-history'

ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# JSON pretty print. Use it like p or pp.
def j(o)
  puts JSON::pretty_generate(JSON::parse(o.to_json))
end
