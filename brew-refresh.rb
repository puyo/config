#!/usr/bin/env ruby

require 'pp'

# brew

installed = IO.popen(['brew', 'list']).readlines.map(&:strip)
wanted = File.readlines('brew-list.txt').map{|w| w.sub(/#.*$/, '').strip }
wanted_deps = IO.popen(['brew', 'deps', '--union', *wanted]).readlines.map(&:strip)
wanted += wanted_deps
to_remove = installed - wanted
to_install = wanted - installed

system('brew', 'update')
system('brew', 'uninstall', '--ignore-dependencies', '--force', *to_remove)
system('brew', 'install', *wanted)
system('brew', 'upgrade')
system('brew', 'cleanup')

# brew cask

cask_wanted = File.readlines('brew-cask-list.txt').map{|w| w.sub(/#.*$/, '').strip }
system('brew', 'cask', 'install', *cask_wanted)
