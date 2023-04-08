module RimeDeploy
  module Mac
    class InstallRimeJob < Job
      def call
        puts intro
        system(OSConfig::Mac::InstallCmd)
        sleep 1
        return :next
      end
    end

    class BackupRimeConfigJob < Job
      def call
        puts "Job: BackupRimeConfigJob".blue
        system(
          "mv #{OSConfig::Mac::ConfigPath} #{OSConfig::Mac::ConfigPath}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system(
          "git clone https://github.com/iDvel/rime-ice.git #{OSConfig::Mac::ConfigPath}"
        )
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system("cp ./custom/default.custom.yaml #{OSConfig::Mac::ConfigPath}/")
        system("cp ./custom/squirrel.custom.yaml #{OSConfig::Mac::ConfigPath}/")
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
        puts "Config path: #{OSConfig::Mac::ConfigPath}/"
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
