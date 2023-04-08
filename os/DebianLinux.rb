module RimeDeploy
  module DebianLinux
    class InstallRimeJob < Job
      def call
        puts intro
        puts "use Rime-ibus".yellow
        system(Config::DebianLinux::InstallCmd)
        sleep 1
        return :next
      end
    end

    class BackupRimeConfigJob < Job
      def call
        puts intro
        system(
          "mv #{Config::DebianLinux::ConfigPath} #{Config::DebianLinux::ConfigPath}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system(
          "git clone #{Config::RIME_CONFIG_REPO} #{Config::DebianLinux::ConfigPath}"
        )
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system(
          "cp ./custom/default.custom.yaml #{Config::DebianLinux::ConfigPath}/"
        )
        system(
          "cp ./custom/squirrel.custom.yaml #{Config::DebianLinux::ConfigPath}/"
        )
        sleep 1
        return :next
      end
    end

    class FinishedJob < Job
      def call
        puts ""
        puts "Tips: When finished all jobs. You need to do follow:".yellow
        puts "1) Restart system."
        puts "2) open Rime input method setting pane and click " +
               "DEPLOY".yellow + " button."
        puts "Enjoy~ 🍻"
        puts "more info:".yellow
        puts "Config path: #{Config::DebianLinux::ConfigPath}/"
        return :next
      end
    end

    Jobs = [
      InstallRimeJob,
      BackupRimeConfigJob,
      CloneConfigJob,
      CopyCustomConfigJob
    ]

    FinishedHook = [FinishedJob]
  end
end
