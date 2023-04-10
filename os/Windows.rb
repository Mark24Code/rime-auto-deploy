module RimeDeploy
  class WindowsJobGroup < JobGroup
    ConfigPath = ENV['APPDATA'] + '\\Rime'


    def clear_screen
      system("cls")
    end

    class CheckInstallRimeJob < Job
      def call
        puts "==== Rime auto deploy ====".green
        puts "Before Check Rime Installed Staus".yellow
        tips = <<-TIP
Windows system doesn't have it's own package manager, so make sure you had installed Rime before.

You can download Rime from: https://rime.im/download/

        TIP
        puts tips
        puts ""
        ChooseSession.new(
          [
            [
              "I have installed Rime. Let's go next.",
              -> {}
            ],
            [
              "I'll quit first.After installed Rime by myself then run this program again.",
              -> { exit 0 }
            ]
          ]
        ).call
        sleep 1
        return :next
      end
    end

    class BackupRimeConfigJob < Job
      def call
        puts intro
        system(
          "move #{WindowsJobGroup::ConfigPath} #{WindowsJobGroup::ConfigPath}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system(
          "git clone --depth=1 #{Config::RIME_CONFIG_REPO} #{WindowsJobGroup::ConfigPath}"
        )
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system("copy .\\custom\\*.yaml #{WindowsJobGroup::ConfigPath}")
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
        puts "Enjoy~"
        puts "more info:".yellow
        puts "Config path: #{WindowsJobGroup::ConfigPath}"
        return :next
      end
    end
    self.before_jobs = [CheckInstallRimeJob]
    self.jobs = [BackupRimeConfigJob, CloneConfigJob, CopyCustomConfigJob]
    self.after_jobs = [FinishedJob]
  end
end
