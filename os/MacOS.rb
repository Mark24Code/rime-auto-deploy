module RimeDeploy
  class MacOSJobGroup < JobGroup
    InstallCmd = "brew install --cask squirrel"
    Store.config_path = "~/Library/Rime"

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
          "mv #{Store.config_path} #{Store.config_path}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system(
          "git clone --depth=1 #{Config::RIME_CONFIG_REPO} #{Store.config_path}"
        )
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system("cp ./custom/*.yaml #{Store.config_path}/")
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
        puts "Config path: #{Store.config_path}/"
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
    self.upgrade_jobs = [
      Upgrade::UpgradeRimeAutoDeployJob,
      Upgrade::UpgradeRimeConfigJob
    ]
  end
end
