module RimeDeploy
  module Linux
    class InstallRimeJob < Job
      def call
        puts intro
        system(OSConfig::Linux::InstallCmd)
        sleep 1
        return :next
      end
    end

    class BackupRimeConfigJob < Job
      def call
        puts "Job: BackupRimeConfigJob".blue
        system(
          "mv #{OSConfig::Linux::ConfigPath} #{OSConfig::Linux::ConfigPath}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system("git clone #{RIME_CONFIG_REPO} #{OSConfig::Linux::ConfigPath}")
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system(
          "cp ./custom/default.custom.yaml #{OSConfig::Linux::ConfigPath}/"
        )
        system(
          "cp ./custom/squirrel.custom.yaml #{OSConfig::Linux::ConfigPath}/"
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
        puts "Config path: #{OSConfig::Linux::ConfigPath}/"
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
