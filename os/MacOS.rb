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
        system("cp ./custom/*.yaml #{MacOSJobGroup::ConfigPath}/")
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

    class UpgradeRimeAutoDeployJob < Job
      def call
        puts "Upgrade `Rime Auto Deploy` script ..."
        project_path = File.expand_path(Dir.pwd)
        if File.directory?(File.join(project_path, ".git"))
          puts "Git repository found."
          system("cd #{project_path} && git remote get-url origin")
          puts "Try upgrading..."
          system("cd #{project_path} && git pull")
        else
          puts "You can download the latest version from here."
          puts "https://github.com/Mark24Code/rime-auto-deploy"
        end
        return :next
      end
    end

    class UpgradeRimeConfigJob < Job
      def call
        puts "Upgrade Rime Config"
        config_path = File.expand_path(ConfigPath)
        if File.directory?(File.join(config_path, ".git"))
          puts "Git repository found."
          system("cd #{config_path} && git remote get-url origin")
          puts "Try upgrading..."
          system("cd #{config_path} && git pull")
        else
          puts "Error:".yellow
          puts "Rime Config seems broken. You may delete the directory.".red
          puts "You can:"
          puts "Rerun the deploy script from start choose [Auto Mode] to reinstall."
          puts ""
          puts "After 5 seconds, will go to [Upgrade Mode].".yellow
          sleep 5
          throw :halt, :run_jobs_upgrade
        end

        return :next
      end
    end

    self.jobs = [
      InstallRimeJob,
      BackupRimeConfigJob,
      CloneConfigJob,
      CopyCustomConfigJob
    ]
    self.upgrade_jobs = [UpgradeRimeAutoDeployJob, UpgradeRimeConfigJob]
    self.after_jobs = [FinishedJob]
  end
end
