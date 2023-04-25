module RimeDeploy
  module Upgrade
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
        config_abs_path = File.expand_path(Store.config_path)
        if File.directory?(File.join(config_abs_path, ".git"))
          puts "Git repository found."
          system("cd #{config_abs_path} && git remote get-url origin")
          puts "Try upgrading..."
          system("cd #{config_abs_path} && git pull")
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
  end
end
