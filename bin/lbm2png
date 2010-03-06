#!/usr/bin/ruby

for fn in ARGV
  fnpcx = File.basename(fn.downcase, '.lbm') + '.pcx'
  fnpng = File.basename(fn.downcase, '.lbm') + '.png'
  puts fnpcx
  system "wine ~/games/danim/CONVERT.EXE -d '#{fn}' -p '#{fnpcx}'" or fail("Could not convert #{fn}")
  puts fnpng
  system "convert '#{fnpcx}' '#{fnpng}'" or fail("Could not convert #{fnpcx}")
  system "rm #{fnpcx}"
end
