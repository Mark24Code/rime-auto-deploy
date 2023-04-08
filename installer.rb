#!/usr/bin/env ruby

require "./lib/core"
require "./lib/config"
module RimeDeploy
  class Installer
    def initialize
      @osname = nil
      check_os
      dispatch
      run
    end
    def check_os
      case RUBY_PLATFORM
      when /darwin/
        @osname = "mac"
      when /linux/
        @osname = "linux"
      when /unix/
        @osname = "unix"
      when /mswin|win32|mingw|cygwin/
        @osname = "win"
        not_support_exit
      else
        not_support_exit
      end
    end

    def not_support_exit
      puts "Not support this system. Bye~"
      exit 0
    end

    def dispatch
      require "./os/#{@osname}"
    end

    def run
      os_prefix = @osname.capitalize
      code = <<-CODE
  class #{os_prefix}JobGroup < JobGroup
  end
  mod = #{os_prefix}JobGroup.new(#{os_prefix}::Jobs, #{os_prefix}::FinishedHook)
  mod.call

CODE
      instance_eval(code)
    end
  end
end

RimeDeploy::Installer.new
