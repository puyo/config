#!/bin/bash

destroot="/Volumes/Seagate Exp"

rsync="rsync
  --whole-file
  --links
  --stats
  --human-readable
  --verbose
  --archive
  --delete
  --delete-excluded
  --partial
  --progress
  --exclude '*~'
  --exclude 'logs/*.log'
  --exclude /.Trash/
  --exclude /.cache/
  --exclude /.gem/
  --exclude /.kde/share/apps/amarok/albumcovers/cache/
  --exclude /.rubies/
  --exclude /.thumbnails/
  --exclude /Library/Caches/
  --exclude /Library/Containers/
  --exclude Cache/
  --exclude _build/
  --exclude cache/
  --exclude node_modules/
  --exclude projects/vendor/
  --exclude tmp/
"

# root of the xfer is considered /Users not /Users/$USER

src="$HOME/"
dest="$destroot$src"

mkdir -p "$dest"

echo $rsync "$src" "$dest"
$rsync "$src" "$dest"
