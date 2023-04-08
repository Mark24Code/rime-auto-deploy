#!/usr/bin/env ruby

require "./lib/core"
require "./lib/config"

module OSPatch
  def check_linux_debian?
    return File.exist?("/etc/debian_version")
  end

  def check_os
    case RUBY_PLATFORM.downcase
    when /darwin/
      @osname = "MacOS"
    when /ubuntu/i
      @osname = "DebianLinux"
    when /debian/i
      @osname = "DebianLinux"
      # when /centos/i
      #   @osname = "CentOS"
      # when /fedora/i
      #   @osname = "Fedora"
      # when /redhat/i
      #   @osname = "Red Hat"
      # when /suse/i
      #   @osname = "SUSE"
      # when /unix/
      #   @osname = "unix"
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
      dispatch
      run
    end

    def not_support_exit
      puts "Not support this system. Bye~"
      exit 0
    end

    def dispatch
      require "./os/#{@osname}"
    end

    def run
      os_prefix = @osname
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
