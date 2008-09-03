function! RedGem(arg1)
ruby << EOF
p VIM.evaluate("a:arg1") # like in normal mode
b = VIM::Buffer.current

def puts(*args)
	p args
end
puts '--'
puts VIM.methods.sort - Class.methods
puts '--'
puts VIM.constants.sort - Class.constants
puts 'Buffer--'
puts VIM::Buffer.methods.sort - Class.methods
puts 'Buffer.current--'
puts VIM::Buffer.current.methods.sort - Class.methods
puts 'Window--'
puts VIM::Window.methods.sort - Class.methods
puts '--'
puts VIM::Window.current.methods.sort - Class.methods
EOF
endfunction
