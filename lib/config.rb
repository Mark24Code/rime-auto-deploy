module RimeDeploy
  RIME_CONFIG_REPO = "https://github.com/iDvel/rime-ice.git"
  module OSConfig
    module Mac
      InstallCmd = "brew install --cask squirrel"
      ConfigPath = "~/Library/Rime"
    end

    module Linux
      InstallCmd = "sudo apt install ibus-rime"
      ConfigPath = "~/.config/ibus/rime/"
    end
  end
end
