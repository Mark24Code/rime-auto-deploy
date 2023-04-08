module RimeDeploy
  class LinuxDistro
    def self.ConfigPath=(value)
      @@ConfigPath = value
    end

    def self.ConfigPath
      @@ConfigPath
    end

    class CheckInstallRimeJob < Job
      def call
        puts intro
        puts "Different Linux has it's own package manager. So make sure you had installed Rime before."
        tips = <<-TIP
Different Linux has it's own package manager. So make sure you had installed Rime before.

For Fcitx5, installfcitx5-rime.
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
                LinuxDistro.ConfigPath =
                  ::RimeDeploy::Config::LinuxDistro::ConfigPathIbus
              end
            ],
            [
              "fcitx-rime",
              -> do
                LinuxDistro.ConfigPath =
                  ::RimeDeploy::Config::LinuxDistro::ConfigPathFcitx
              end
            ],
            [
              "fcitx5-rime",
              -> do
                LinuxDistro.ConfigPath =
                  ::RimeDeploy::Config::LinuxDistro::ConfigPathFcitx5
              end
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
          "mv #{LinuxDistro.ConfigPath} #{LinuxDistro.ConfigPath}.#{Time.now.to_i}.old"
        )
        sleep 1
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system(
          "git clone --depth=1 #{Config::RIME_CONFIG_REPO} #{LinuxDistro.ConfigPath}"
        )
        sleep 1
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system("cp ./custom/default.custom.yaml #{LinuxDistro.ConfigPath}/")
        system("cp ./custom/squirrel.custom.yaml #{LinuxDistro.ConfigPath}/")
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
        puts "Config path: #{LinuxDistro.ConfigPath}/"
        return :next
      end
    end

    BeforeHook = [CheckInstallRimeJob]

    Jobs = [BackupRimeConfigJob, CloneConfigJob, CopyCustomConfigJob]

    FinishedHook = [FinishedJob]
  end
end
