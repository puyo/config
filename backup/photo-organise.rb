#!/usr/bin/env ruby
#
# Move files into folders based on time stamps.
#
#     FORREALZ=1 ruby photo-organise.rb
#

def ensure_dep(name, version)
  gem name, version
rescue Gem::LoadError => e
  puts e.message
  system('gem', 'install', name, '-v', version) or
    raise("Could not find right version of #{name} (require version #{version})")
  system($PROGRAM_NAME, *ARGV)
  exit $CHILD_STATUS.exitstatus
end

ensure_dep 'progress', '>= 3.6.0'
ensure_dep 'exif', '>= 2.2.1'

require 'fileutils'
require 'pp'
require 'progress'
require 'yaml'
require 'exif'
require 'date'
require 'digest'

# To run:
#
#     Organise.new.organise
#
class Organise
  RE_DATE = /^(?:19|20)\d{2}-\d{2}-\d{2}/.freeze
  RE_MONTH = /^(?:19|20)\d{2}-\d{2}/.freeze

  def add_new_info
    paths.with_progress("checking #{paths.size} files").each do |path|
      info[path] = update_photo_info(info[path] || {}, path)
    end
  end

  def calc_sum(path)
    Digest::MD5.file(path).to_s
  end

  def calc_date(path)
    calc_exif_date(path) ||
      calc_filename_date(path) ||
      calc_related_date(path) ||
      calc_same_day_date(path)
  end

  def calc_dupes
    dupes = Hash.new { |h, k| h[k] = [] }
    info.each { |path, photo| dupes[photo['sum']] << path }
    dupes.values.select { |paths| paths.size > 1 }
  end

  def calc_exif_date(path)
    data = Exif::Data.new(File.open(path))
    exif = data[:exif] || {}
    date_s = data.date_time || exif[:date_time] || exif[:date_time_original] || exif[:date_time_digitized]
    date_s[0, 10].tr(':', '-') if date_s
  rescue Exif::NotReadable
    nil
  end

  def calc_filename_date(path)
    path.split(File::SEPARATOR).reverse.each do |seg|
      return seg[0, 10] if RE_DATE.match?(seg)
      return "#{seg[0, 7]}-01" if RE_MONTH.match?(seg)
    end
    nil
  rescue Date::Error
    nil
  end

  def calc_related_date(path)
    calc_related_paths(path).each do |related_path|
      result = calc_exif_date(related_path)
      return result if result
    end
    nil
  end

  # Calculate a file's date by comparing for example IMG_123.JPG with
  # IMG_122.JPG and IMG_124.JPG - if files on either side in order have
  # the same date, then assume that date for this file too.
  def calc_same_day_date(path)
    ext = File.extname(path)
    base = File.basename(path, ext)
    dir = File.dirname(path)
    base_glob = base.gsub(/\d/, '[0-9]')
    glob = File.join(dir, "#{base_glob}.*")
    paths = Dir.glob(glob).sort
    index = paths.index(path)
    d0 = (index - 1).downto(0).lazy.filter_map { |i| calc_exif_date(paths[i]) }.first
    d1 = (index + 1).upto(paths.size - 1).lazy.filter_map { |i| calc_exif_date(paths[i]) }.first
    return d0 if d0 && d1

    nil
  end

  def calc_related_paths(path)
    ext = File.extname(path)
    base = File.basename(path, ext)
    dir = File.dirname(path)
    glob = File.join(dir, [base, '*'].join('.'))
    Dir.glob(glob) - [path]
  end

  def dedupe
    changes = false
    found = false
    calc_dupes.each do |paths|
      exists = paths.find { |path| File.exist?(path) }
      next unless exists

      redundant = paths - [exists]
      if dedupe?
        redundant.each do |path|
          FileUtils.rm_rf(path, verbose: true)
          info.delete(path)
          changes = true
        end
      else
        puts "Dedupe: #{exists}"
        redundant.each { |x| puts "- DUPE: #{x}" }
        found = true
      end
    end
    if !dedupe? && found
      puts
      puts "Call with FORREALZ=1 #{$PROGRAM_NAME} to make these changes"
    end
    write_info if changes
  end

  def dedupe?
    ENV['FORREALZ'] == '1'
  end

  def dest_base(path, date)
    base = File.basename(path)
    return base if date.nil?

    prefix = "#{date}_"
    return base if base.start_with?(prefix)

    "#{prefix}#{base}"
  end

  def dest_dir(date)
    if date
      date[0, 4]
    else
      '0_unknown_date'
    end
  end

  def info_path
    'photo-info.yml'
  end

  def info
    @info ||= load_info
  end

  def load_info
    if File.exist?(info_path)
      YAML.load_file(info_path)
    else
      {}
    end
  end

  def move_into_date_dirs
    paths.each do |path|
      photo = info[path]
      date = photo['date']
      dest_base = dest_base(path, date)
      dest_dir = dest_dir(date)
      desired_path = "photos/#{dest_dir}/#{dest_base}"
      next unless path != desired_path

      FileUtils.mkdir_p(File.dirname(desired_path))
      FileUtils.mv(path, desired_path, verbose: true)
      info[desired_path] = photo
      info.delete(desired_path)
    end
    write_info
    remove_empty_dirs
  end

  # 1. Sync down a subset of all photos (current year + previous year, by
  #    default)
  #
  # 2. Load info for year (yml/csv)
  #
  # 3. Select info (IF it would be in the subset of all photos, and file
  #    exists)
  #
  # 4. Add new info for any new files in directory
  #
  # 5. Move all files into their correct location if they are not there
  #    already (YYYY/YYYY-MM-DD_<existing name>.<existing ext>), updating
  #    info
  #
  # 6. Sync up the subset of photos with --delete
  #
  def organise
    # update_info

    dedupe

    # pp info.sort_by { |_path, photo| photo['date'] || '' }
    # pp info.values.map { |photo| dest_dir(photo['date']) }.uniq.sort
    # pp info.group_by { |_path, photo| dest_dir(photo['date']) }.map { |dir, files| [dir, files.size] }.sort

    # move_into_date_dirs
  end

  def paths
    @paths ||= Dir.glob('photos/**/*').select { |path| File.exist?(path) && !Dir.exist?(path) }
  end

  def remove_empty_dirs
    system('find photos/ -name .DS_Store -type f -delete')
    system('find photos/ -empty -type d -delete')
  end

  def update_info
    info.delete_if { |path, _photo_info| !File.exist?(path) }
    add_new_info
    write_info
  end

  def update_photo_date(photo, path)
    case ENV['DATE']
    when 'force'
      date = calc_date(path)
      photo['date'] = calc_date(path) if date
    when 'skip'
      # OK
    else
      if photo['date'].nil?
        date = calc_date(path)
        photo['date'] = date if date
      end
    end
    photo
  end

  def update_photo_info(photo, path)
    update_photo_sum(photo, path)
    update_photo_date(photo, path)
    photo
  end

  def update_photo_sum(photo, path)
    case ENV['SUM']
    when 'force'
      photo['sum'] = calc_sum(path)
    when 'skip'
      # OK
    else
      photo['sum'] ||= calc_sum(path)
    end
    photo
  end

  def write_info
    File.open(info_path, 'w') { |f| YAML.dump(info, f) }
  end
end

Organise.new.organise
