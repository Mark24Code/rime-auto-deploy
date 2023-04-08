module RimeDeploy
  class LinuxDistro
    @@config_path = nil
    def self.config_path=(value)
      @@config_path = value
    end

    def self.config_path
      @@config_path
    end

    class CheckInstallRimeJob < Job
      def call
        puts @title
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
                LinuxDistro.config =
                  ::RimeDeploy::Config::LinuxDistro::ConfigPathIbus
              end
            ],
            [
              "fcitx-rime",
              -> do
                LinuxDistro.config =
                  ::RimeDeploy::Config::LinuxDistro::ConfigPathFcitx
              end
            ],
            [
              "fcitx5-rime",
              -> do
                LinuxDistro.config_path =
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

    BeforeHook = [CheckInstallRimeJob]

    Jobs = [BackupRimeConfigJob, CloneConfigJob, CopyCustomConfigJob]

    FinishedHook = [FinishedJob]
  end
end
