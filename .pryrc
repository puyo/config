#!/usr/bin/ruby
#
# frozen_string_literal: true

begin
  require 'pry-byebug'
rescue LoadError
  nil
end

begin
  require 'pry-doc'
rescue LoadError
  nil
end

# vim FTW
Pry.config.editor = 'gvim --nofork'

if defined?(PryDebugger) || defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
  Pry::Commands.command(/^$/, 'repeat last command') do
    pry_instance.run_command Pry.history.to_a.last
  end
end

send(:include, Rails::ConsoleMethods) if defined?(Rails::ConsoleMethods)
