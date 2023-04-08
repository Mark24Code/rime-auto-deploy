require "./lib/core"

class MacOSJobGroup < JobGroup
end

class InstallRimeJob < Job
  def call
    puts "Job: InstallRimeJob".blue
    sleep 1
    # system("brew install --cask squirrel")
    return :next
  end
end

class BackupRimeConfigJob < Job
  def call
    puts "Job: BackupRimeConfigJob".blue
    sleep 1
    # system("mv ~/Library/Rime ~/Library/Rime.#{Time.now.to_i}.old")
    return :next
  end
end

class CloneConfigJob < Job
  def call
    puts "Job: CloneConfigJob".blue
    sleep 1
    # system(
    #   "git clone --depth=1 https://github.com/Mark24Code/rime-ice.git ~/Library/Rime"
    # )
    return :next
  end
end

class CopyCustomConfigJob < Job
  def call
    puts "Job: CopyCustomConfigJob".blue
    sleep 1
    # system("cp ./default.custom.yaml ~/Library/Rime/")
    # system("cp ./squirrel.custom.yaml ~/Library/Rime/")
    return :next
  end
end

MacOSJobGroup.new(
  [InstallRimeJob, BackupRimeConfigJob, CloneConfigJob, CopyCustomConfigJob]
).call
