module RimeDeploy
  class MacOSJobGroup < JobGroup
    InstallCmd = "brew install --cask squirrel"
    ConfigPath = "~/Library/Rime"

    class InstallRimeJob < Job
      def call
        puts intro
        system(InstallCmd)
        sleep 1
        return :next
      end
    end

    class BackupRimeConfigJob < Job
      def call
        puts intro
        system(
          "mv #{MacOSJobGroup::ConfigPath} #{MacOSJobGroup::ConfigPath}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system(
          "git clone --depth=1 #{Config::RIME_CONFIG_REPO} #{MacOSJobGroup::ConfigPath}"
        )
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system("cp ./custom/default.custom.yaml #{MacOSJobGroup::ConfigPath}/")
        system("cp ./custom/squirrel.custom.yaml #{MacOSJobGroup::ConfigPath}/")
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
        puts "Config path: #{MacOSJobGroup::ConfigPath}/"
        return :next
      end
    end
    self.jobs = [
      InstallRimeJob,
      BackupRimeConfigJob,
      CloneConfigJob,
      CopyCustomConfigJob
    ]
    self.after_jobs = [FinishedJob]
  end
end
