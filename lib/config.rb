module RimeDeploy
  module OSDetect
  end
  module Config
    RIME_CONFIG_REPO = "https://github.com/iDvel/rime-ice.git"
    class MacOS
      InstallCmd = "brew install --cask squirrel"
      ConfigPath = "~/Library/Rime"
    end

    class LinuxDistro
      ConfigPathIbus = "~/.config/ibus/rime"
      ConfigPathFcitx = "~/.config/fcitx/rime"
      ConfigPathFcitx5 = "~/.local/share/fcitx5/rime"
    end
  end
end
