#!/usr/bin/ruby
#
# frozen_string_literal: true

begin
  require 'pry-byebug'
rescue LoadError
  nil
end

# vim FTW
Pry.config.editor = 'gvim --nofork'

# Prompt with ruby version
Pry.prompt = [
  proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " },
  proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }
]

# # Load rails configuration if it is running as a rails console
# path = File.dirname(__FILE__) + '/.railsrc'
# load path if File.exist?(path) && defined?(Rails) && Rails.env

if defined?(PryDebugger) || defined?(PryByebug)
  # Pry.commands.alias_command 'c', 'continue'
  # Pry.commands.alias_command 's', 'step'
  # Pry.commands.alias_command 'n', 'next'
  # Pry.commands.alias_command 'f', 'finish'
  Pry::Commands.command(/^$/, 'repeat last command') do
    _pry_.run_command Pry.history.to_a.last
  end
end

send(:include, Rails::ConsoleMethods) if defined?(Rails::ConsoleMethods)
