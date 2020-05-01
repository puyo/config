#!/usr/bin/env ruby
#
# Use brew-list.txt as a master list of packages to ensure are installed. Any
# brew packages NOT in this file will be uninstalled (after a prompt).
#
# Use brew-cask-list.txt as a master list of brew cask packages to ensure are
# installed. No casks are uninstalled at this time.

require 'pp'

# brew

installed = IO.popen(['brew', 'list']).readlines.map(&:strip)
wanted = File.readlines('brew-list.txt').map{|w| w.sub(/#.*$/, '').strip }
wanted_deps = IO.popen(['brew', 'deps', '--union', *wanted]).readlines.map(&:strip)
wanted += wanted_deps
to_remove = installed - wanted
to_install = wanted - installed

system('brew', 'update')
if to_remove.any?
  begin
    puts to_remove.join(' ') + "\n\nRemove these packages? (y/N) "
    x = gets
  end until x.strip.downcase == 'y'
  system('brew', 'uninstall', '--ignore-dependencies', '--force', *to_remove)
end

if to_install.any?
  begin
    puts to_install.join(' ') + "\n\nInstall these packages? (y/N) "
    x = gets
  end until x.strip.downcase == 'y'
  system('brew', 'install', *to_install)
end
system('brew', 'upgrade')
system('brew', 'cleanup')

# brew cask

cask_wanted = File.readlines('brew-cask-list.txt').map{|w| w.sub(/#.*$/, '').strip }
system('brew', 'cask', 'install', *cask_wanted)
