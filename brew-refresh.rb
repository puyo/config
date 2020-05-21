#!/usr/bin/env ruby
#
# Use brew-list.txt as a master list of packages to ensure are installed. Any
# brew packages NOT in this file will be uninstalled (after a prompt).
#
# Use brew-cask-list.txt as a master list of brew cask packages to ensure are
# installed. No casks are uninstalled at this time.

require 'pp'
require 'shellwords'

def confirm(prompt)
  loop do
    puts "#{prompt} (y/N) "
    x = gets.strip.downcase
    case x
    when 'y'
      yield
      break
    when 'n'
      puts "Cancelled"
      break
    end
  end
end

def system_verbose(*args)
  blue = "\033[01;34m"
  reset = "\033[00m"
  print blue
  puts Shellwords.join(args)
  print reset
  system(*args)
end

def read_brew_command(*cmd)
  IO.popen(cmd).readlines.map(&:strip)
end

def read_brew_list_file(path)
  File.readlines(path).map{|w| w.sub(/#.*$/, '').strip }
end

# brew

installed = read_brew_command('brew', 'list')
wanted = read_brew_list_file('brew-list.txt')

wanted_deps = read_brew_command('brew', 'deps', '--union', *wanted)
# begin
#   new_wanted_deps = read_brew_command('brew', 'deps', '--union', *wanted, *wanted_deps)
#   wanted_deps |= new_wanted_deps
# end while wanted_deps != new_wanted_deps
wanted += wanted_deps
to_remove = installed - wanted
to_install = wanted - installed

system_verbose('brew', 'update')

if to_remove.any?
  confirm("\n#{to_remove.join(' ')}\n\nRemove these packages?") do
    # force means all versions
    #system_verbose('brew', 'uninstall', '--ignore-dependencies', '--force', *to_remove)
    system_verbose('brew', 'uninstall', '--force', *to_remove)
  end
end

if to_install.any?
  confirm("\n#{to_install.join(' ')}\n\nInstall these packages?") do
    system_verbose('brew', 'install', *to_install)
  end
end

system_verbose('brew', 'upgrade')
system_verbose('brew', 'cleanup')

# brew cask

wanted = read_brew_list_file('brew-cask-list.txt')
installed = read_brew_command('brew', 'cask', 'list')
to_remove = installed - wanted
to_install = wanted - installed

if to_remove.any?
  confirm("\n#{to_remove.join(' ')}\n\nRemove these cask packages?") do
    system_verbose('brew', 'cask', 'uninstall', '--ignore-dependencies', '--force', *to_remove)
  end
end

if to_install.any?
  confirm("\n#{to_install.join(' ')}\n\nInstall these cask packages?") do
    system_verbose('brew', 'cask', 'install', *to_install)
  end
end

system_verbose('brew', 'cask', 'upgrade')
