#!/usr/bin/env ruby
#
# Calculate checksums on photos and potentially remove duplicates.
#
# Generate or update checksums.yml
#
#     ruby checksums.rb
#
# Remove duplciates
#
#     FORREALZ=1 ruby checksums.rb
#

begin
  gem 'progress'
rescue Gem::MissingSpecError
  system('gem install progress') || fail('Could not install progress gem')
  retry
end

require 'digest'
require 'fileutils'
require 'pp'
require 'progress'
require 'yaml'

module Checksums
  class << self
    def checksums_path
      'photo-checksums.yml'
    end

    def add_checksums(result)
      paths = Dir.glob('photos/**/*').select{ |path| File.exist?(path) && !Dir.exist?(path) }

      puts "#{paths.size} files..."

      paths.with_progress('checksumming').each do |path|
        if !result.key?(path)
          md5 = Digest::MD5.file(path).to_s
          result[path] = md5
        end
      end
      result
    end

    def load_checksums
      YAML.load_file(checksums_path) if File.exist?(checksums_path)
    end

    def main
      result = load_checksums
      result.delete_if { |path, md5| !File.exist?(path) }
      result = add_checksums(result || {})
      File.open(checksums_path, 'w') { |f| YAML.dump(result, f) }

      dupes = Hash.new { |h, k| h[k] = [] }
      result.each do |path, md5|
        dupes[md5] << path
      end
      dupes = dupes.values.select { |paths| paths.size > 1 }

      dupes.each do |paths|
        exists = paths.find { |path| File.exist?(path) }
        if exists
          redundant = paths - [exists]
          redundant.each { |path| FileUtils.rm_rf(path, verbose: true, noop: ENV['FORREALZ'] != '1') }
        end
      end
    end
  end
end

Checksums.main

