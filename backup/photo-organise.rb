#!/usr/bin/env ruby
#
# Move files into folders based on time stamps.
#
#     FORREALZ=1 ruby photo-organise.rb
#

def ensure_dep(name, version)
  gem name, version
rescue Gem::LoadError
  system('gem', 'install', name, '-v', version) or
    raise("Could not find right version of #{name} (require version #{version})")
  ok = system($PROGRAM_NAME, *ARGV)
  exit ok ? 0 : 1
end

ensure_dep 'progress', '>= 3.6.0'
ensure_dep 'exif', '>= 2.2.1'

require 'fileutils'
require 'pp'
require 'progress'
require 'yaml'
require 'exif'
require 'date'

# To run:
#
#     Organise.new.organise
#
class Organise
  DATE_RE = /^\d{4}-\d{2}-\d{2}/

  def checksums_path
    'photo-checksums.yml'
  end

  def load_checksums
    YAML.load_file(checksums_path) if File.exist?(checksums_path)
  end

  def load_dates
    YAML.load_file(dates_path) if File.exist?(dates_path)
  end

  def dates_path
    'photo-dates.yml'
  end

  def paths
    @paths ||= Dir.glob('photos/**/*').select { |path| File.exist?(path) && !Dir.exist?(path) }
  end

  def add_new_checksums
    paths.with_progress('checksumming').each do |path|
      next if checksums.key?(path)

      checksums[path] = Digest::MD5.file(path).to_s
    end
  end

  def add_new_dates
    paths.with_progress('dating').each do |path|
      next if dates.key?(path)

      dates[path] = calc_date(path)
    end
  end

  def calc_date(path)
    filename_date(path) || exif_date(path) || '?'
  end

  def filename_date(path)
    basename = File.basename(path)
    basename[0, 10] if DATE_RE.match?(basename)
  rescue Date::Error
    nil
  end

  def exif_date(path)
    data = Exif::Data.new(File.open(path))
    exif = data[:exif] || {}
    date_s = data.date_time || exif[:date_time] || exif[:date_time_original] || exif[:date_time_digitized]
    date_s[0, 10].tr(':', '-') if date_s
  rescue Exif::NotReadable
    nil
  end

  def move_into_date_dirs
    dates.each do |path, date|
      # p path: path, date: date

      basename = File.basename(path)
      dir = dest_dir(date)
      # current_dir = File.dirname(path)
      desired_path = "photos/#{dir}/#{basename}"
      p path => desired_path
    end
  end

  def dest_dir(date)
    if date == '?'
      '_date_unknown'
    else
      date[0, 7]
    end
  end

  def update_dates
    dates.delete_if { |path, _md5| !File.exist?(path) }
    add_new_dates
    File.open(dates_path, 'w') { |f| YAML.dump(dates, f) }
    pp dates.values.map { |date| dest_dir(date) }.uniq.sort
    pp dates.group_by { |_path, date| dest_dir(date) }.map { |dir, files| [dir, files.size] }.sort

    # move_into_date_dirs
  end

  def checksums
    @checksums ||= load_checksums || {}
  end

  def dates
    @dates ||= load_dates || {}
  end

  def update_checksums
    checksums.delete_if { |path, _md5| !File.exist?(path) }
    add_new_checksums
    File.open(checksums_path, 'w') { |f| YAML.dump(checksums, f) }

    dupes = Hash.new { |h, k| h[k] = [] }
    checksums.each do |path, md5|
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

  def organise
    puts "#{paths.size} files..."
    # update_checksums
    update_dates
  end
end

Organise.new.organise
