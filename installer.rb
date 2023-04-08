#!/usr/bin/env ruby

require "./lib/core"
require "./lib/config"

module OSPatch
  def check_os
    case RUBY_PLATFORM.downcase
    when /darwin/
      @osname = "MacOS"
    when /linux/
      @osname = "LinuxDistro"
    when /mswin|win32|mingw|cygwin/
      @osname = "win"
      not_support_exit
    else
      not_support_exit
    end
  end
end
module RimeDeploy
  class Installer
    include OSPatch
    def initialize
      @osname = nil
      check_os
      run
    end

    def not_support_exit
      puts "Not support this system. Bye~"
      exit 0
    end

    def run
      require "./os/#{@osname}"
      instance_eval("#{@osname}JobGroup.new.call")
    end
  end
end

RimeDeploy::Installer.new
