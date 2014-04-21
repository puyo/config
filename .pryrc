require 'rubygems'
require '~/.irb/irb/gem_loader'
require '~/.irb/irb/pry_loader'
require '~/.irb/irb/awesome_print_loader'
require '~/.irb/irb/bypass_reloader'
require '~/.irb/irb/rails_env_switcher'
require '~/.irb/irb/rspec_console'
require '~/.irb/irb/cucumber_console'
require '~/.irb/irb/rails_colors'
#require '~/.irb/irb/mongoid_colors'
require '~/.irb/irb/plot'
require '~/.irb/irb/rails_commands'

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
