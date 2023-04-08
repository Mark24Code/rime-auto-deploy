module RimeDeploy
  module Mac
    class InstallRimeJob < Job
      def call
        puts intro
        system("brew install --cask squirrel")
        return :next
      end
    end

    class BackupRimeConfigJob < Job
      def call
        puts "Job: BackupRimeConfigJob".blue
        system("mv ~/Library/Rime ~/Library/Rime.#{Time.now.to_i}.old")
        return :next
      end
    end

    class CloneConfigJob < Job
      def call
        puts intro
        system("git clone https://github.com/iDvel/rime-ice.git ~/Library/Rime")
        return :next
      end
    end

    class CopyCustomConfigJob < Job
      def call
        puts intro
        system("cp ./custom/default.custom.yaml ~/Library/Rime/")
        system("cp ./custom/squirrel.custom.yaml ~/Library/Rime/")
        return :next
      end
    end

    class FinishedJob < Job
      def call
        puts "Please restart system then open Rime Setting and click DEPLOY."
        return :next
      end
    end

    Jobs = [
      InstallRimeJob,
      BackupRimeConfigJob,
      CloneConfigJob,
      CopyCustomConfigJob,
      FinishedJob
    ]
  end
end
