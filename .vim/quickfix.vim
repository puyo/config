" Function for compilation in background with progressively updated quickfix
" buffer.
" vim:ts=2:sw=2:et:sts

nmap <C-F12> :call QuickFixRefresh()<CR>
imap <C-F12> <ESC>:call QuickFixRefresh()<CR>a
vmap <C-F12> <ESC>:call QuickFixRefresh()<CR>v

" Runs a command in the background with progressive output in the quickfix
" window. Requires gvim (relies on vim server).
function! QuickFix(...)
  if a:0 > 1
    let i=1
    let command=[]
    while i<=a:0
      let command += [a:{i}]
      let i += 1
    endwhile
  else
    let command = a:1
  endif
ruby << EORUBY

  module Shell
    # Escape string so that it interpreted right by sh/bash.
    # Like Regexp.escape but for shell scripts.
    def self.escape(string)
      if string !~ %r{[ "\\]}i 
        string 
      else
        '"' + string.gsub(%r{(["\\])}i, '\\\\\1') + '"'
      end
    end

    # Turn a set of commands such as those from ARGV into a string
    # that can be passed to IO.popen or `` or similar without messing
    # up due to spaces in filenames etc.
    def self.command(args)
      args.map{|x| escape(x) }.join(' ')
    end
  end

  module VIM

    # Like evaluate but returns a Ruby array from a VIM array value.
    def self.evaluate_array(str)
      evaluate(str).split(/\n/m)
    end

    module Quickfix
      def self.path()
        "/tmp/vim.quickfix"
      end

      def self.truncate()
        File.open(path, "w")
      end

      def self.append(line)
        File.open(path, "a") do |f|
          f.print line
        end
      end

      def self.reload()
        VIM.command("cgetfile #{path}")
      end
    end
  end

  command = Shell.command(VIM.evaluate_array("l:command"))
  VIM::Quickfix.truncate
  VIM.command("copen")

  fork do
    IO.popen(command) do |io|
      io.each_line do |line|
        # Append the line to the file.
        VIM::Quickfix.append(line)

        # Refresh the quickfix buffer in Vim from the file.
        # No nice way to do this! :(
        # Here are the alternatives I've played with:

        # Using VIM.command("cfile ..") here causes errors like:
        #   Xlib: unexpected async reply
        # because we are in a sub-process and vim gets confused. (?)

        #VIM::Quickfix.reload

        # Use --remote-send, to emulate typing the refresh command myself.
        # This makes the window flicker, takes you out of insert mode, and
        # generally makes continuing to use gvim impossible while the
        # compilation progresses. But it doesn't crash vim...

        #system("gvim", "--remote-send", 
        #  "<ESC>:cgetfile #{VIM::Quickfix.path}<CR>")

        # A variant on that theme. Pre-defined keybinding that works in all
        # modes. Lots of flickering, same as above.

        #system("gvim", "--remote-send", "<C-F12>")

        # Another variation, try using silent!
        #`gvim --remote-send '<ESC>:silent! exec "silent! cgetfile #{VIM::Quickfix.path}"<CR>'`
        #break if $? != 0

        # Idea: user --remote-expr to call a function we define. An expression
        # with a side-effect.
        # This works really really nicely - it doesn't disrupt editing - but
        # sometimes causes a segment violation which crashes gvim :(

        #output = `gvim --remote-expr 'QuickFixRefresh()'`.strip
        # output should be '0'
      end
    end
  end
EORUBY
endfunction

function! QuickFixRefresh()
  exe "cgetfile /tmp/vim.quickfix"
endfunction

