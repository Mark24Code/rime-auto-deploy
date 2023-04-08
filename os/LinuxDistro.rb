module RimeDeploy
  class LinuxDistroJobGroup < JobGroup
    ConfigPathIbus = "~/.config/ibus/rime"
    ConfigPathFcitx = "~/.config/fcitx/rime"
    ConfigPathFcitx5 = "~/.local/share/fcitx5/rime"

    @config_path = nil
    def self.config_path=(value)
      @config_path = value
    end

    def self.config_path
      @config_path
    end

    class CheckInstallRimeJob < Job
      def call
        puts "==== Rime auto deploy ====".green
        puts "Before Check Rime Installed Staus".yellow
        tips = <<-TIP
Different Linux has it's own package manager. So make sure you had installed Rime before.

For Fcitx5, install fcitx5-rime.
For Fcitx, install fcitx-rime.
For IBus, install ibus-rime.

more:
https://wiki.archlinux.org/title/Rime
        TIP
        puts tips
        puts ""
        puts "Then choose what your had installed."
        ChooseSession.new(
          [
            [
              "ibus-rime",
              -> do
                LinuxDistro.config_path = LinuxDistroJobGroup::ConfigPathIbus
              end
            ],
            [
              "fcitx-rime",
              -> do
                LinuxDistro.config_path = LinuxDistroJobGroup::ConfigPathFcitx
              end
            ],
            [
              "fcitx5-rime",
              -> do
                LinuxDistro.config_path = LinuxDistroJobGroup::ConfigPathFcitx5
              end
            ],
            [
              "I'll quit first.After installed Rime byself then run this program again.",
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
          "mv #{LinuxDistro.config_path} #{LinuxDistro.config_path}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system(
          "git clone --depth=1 #{Config::RIME_CONFIG_REPO} #{LinuxDistro.config_path}"
        )
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system("cp ./custom/default.custom.yaml #{LinuxDistro.config_path}/")
        system("cp ./custom/squirrel.custom.yaml #{LinuxDistro.config_path}/")
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
        puts "Config path: #{LinuxDistro.config_path}/"
        return :next
      end
    end
    self.before_jobs = [CheckInstallRimeJob]
    self.jobs = [BackupRimeConfigJob, CloneConfigJob, CopyCustomConfigJob]
    self.after_jobs = [FinishedJob]
  end
end
