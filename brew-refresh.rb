#!/usr/bin/env ruby
#
# Use brew-list.txt as a master list of packages to ensure are installed. Any
# brew packages NOT in this file will be uninstalled (after a prompt).
#
# Use brew-cask-list.txt as a master list of brew cask packages to ensure are
# installed. No casks are uninstalled at this time.

require 'pp'
require 'shellwords'
require 'open3'
require 'set'
require 'json'

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
  output, status = Open3.capture2(*cmd)
  if status.success?
    output.split($/)
  else
    warn "Command failed with exit status #{status.exitstatus}: #{Shellwords.join(cmd)}"
    exit status.exitstatus
  end
end

def read_brew_list_file(path)
  File.readlines(path).map{|w| w.sub(/#.*$/, '').strip }
end

def brew_aliases(pkgs)
  cmd = ['brew', 'info', '--json=v2', *pkgs]
  output, status = Open3.capture2(*cmd)
  if status.success?
    data = JSON.parse(output)
    alias_lists = data['formulae'].map{|d| [d['name']] + d['aliases'] } +
      data['casks'].map{|d| [d['name']] }
    pkgs.flat_map{|p| alias_lists.find{|l| l.include?(p) } }
  else
    warn "Command failed with exit status #{status.exitstatus}: #{Shellwords.join(cmd)}"
    exit status.exitstatus
  end
rescue
  require 'pry'
  binding.pry
end

# brew taps

wanted_taps = read_brew_list_file('brew-taps.txt')
installed_taps = read_brew_command('brew', 'tap')
to_install_taps = wanted_taps - installed_taps
if to_install_taps.any?
  to_install_taps.each do |tap|
    system_verbose "brew", "tap", tap
  end
end

# brew packages

installed = read_brew_command('brew', 'list', '--formula')
wanted = read_brew_list_file('brew-list.txt')

wanted_deps = Hash.new {|h, k| h[k] = [] }
wanted_deps_for_each = read_brew_command('brew', 'deps', '--union', '--for-each', *wanted)
wanted_deps_for_each.each do |line|
  pkg, deps = line.split(':')
  deps = deps.split(' ')
  deps.each do |dep|
    wanted_deps[dep] << pkg
  end
end

wanted += wanted_deps.keys
to_remove = installed - wanted - brew_aliases(wanted)
to_install = wanted - installed - brew_aliases(installed)

system_verbose('brew', 'update')

if to_remove.any?
  confirm("\n#{to_remove.join(' ')}\n\nRemove these packages?") do
    # force means all versions
    system_verbose('brew', 'uninstall', '--force', *to_remove)
  end
end

if to_install.any?
  msg = to_install.map{|dep|
    pkgs = wanted_deps[dep]
    if pkgs.any?
      "#{dep} (used by #{wanted_deps[dep].join(', ')})"
    else
      dep
    end
  }.join("\n")
  confirm("\n#{msg}\n\nInstall these packages?") do
    system_verbose('brew', 'install', *to_install)
  end
end

system_verbose('brew', 'upgrade')
system_verbose('brew', 'cleanup')

# brew cask

wanted = read_brew_list_file('brew-cask-list.txt')
installed = read_brew_command('brew', 'list', '--cask')
to_remove = installed - wanted
to_install = wanted - installed

if to_remove.any?
  confirm("\n#{to_remove.join(' ')}\n\nRemove these cask packages?") do
    system_verbose('brew', 'cask', 'uninstall', *to_remove)
  end
end

if to_install.any?
  confirm("\n#{to_install.join(' ')}\n\nInstall these cask packages?") do
    system_verbose('brew', 'cask', 'install', *to_install)
  end
end

system_verbose('brew', 'upgrade', '--cask')
