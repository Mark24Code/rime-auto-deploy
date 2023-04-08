module RimeDeploy
  module OSDetect
  end
  module Config
    RIME_CONFIG_REPO = "https://github.com/iDvel/rime-ice.git"
    class MacOS
      InstallCmd = "brew install --cask squirrel"
      ConfigPath = "~/Library/Rime"
    end

    class DebianDistroLinux
      DebianDistro = %w[debian ubuntu linuxmint linux-mint]
      InstallCmd = "sudo apt install ibus-rime"
      ConfigPath = "~/.config/ibus/rime"
    end
  end
end
