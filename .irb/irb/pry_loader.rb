module IRB
  module Pry
    def self.setup
      return unless IRB.try_require 'pry'

      load_pry_plugins
      trap_winchange

      ::Pry.prompt = [proc { |obj, nest_level| "#{self.pwd} (#{obj}) > " },
                      proc { |obj, nest_level| "#{self.pwd} (#{obj}) * " }]
      @@home = Dir.home
    end

    def self.load_pry_plugins
      IRB.try_require 'pry-doc'
      IRB.try_require 'pry-debugger'
      IRB.try_require 'pry-stack_explorer'
    end

    def self.trap_winchange
      # thanks @rking
      trap :WINCH do
        size = `stty size`.split(/\s+/).map(&:to_i)
        Readline.set_screen_size(*size)
        Readline.refresh_line
      end
    end

    def self.pwd
      Dir.pwd.gsub(/^#{@@home}/, '~')
    end
  end

  class TopLevel
    def to_s
      defined?(Rails) ? Rails.env : "main"
    end
    Object.__send__(:include, Rails::ConsoleMethods) if defined?(Rails::ConsoleMethods)
  end
end

IRB::Pry.setup
