class RimeDeployError < StandardError
end

module FontStylePatch
  RESET_COLOR = "\e[0m" #重置所有颜色和样式
  COLORS = {
    black: "\e[30m", #黑色文本
    red: "\e[31m", #红色文本
    green: "\e[32m", #绿色文本
    yellow: "\e[33m", #黄色文本
    blue: "\e[34m", #蓝色文本
    carmine: "\e[35m", #洋红色文本
    cyan: "\e[36m", #青色文本
    white: "\e[37m" #白色文本
  }
  COLORS.keys.each do |color_name|
    define_method(color_name) do
      return "#{COLORS[color_name]}#{self}#{RESET_COLOR}"
    end
  end
end

module StringPatch
  def nature_case
    self.gsub(/(.)([A-Z])/, '\1 \2').downcase.capitalize
  end
end

class String
  include FontStylePatch
  include StringPatch
end

class ChooseSession
  def initialize(items)
    @items = items #[[intro, method]] auto index
  end

  def call
    message = nil
    choose = nil
    while true
      puts @title
      puts "Choose mode:"
      @items.each_with_index { |item, index| puts "[#{index + 1}] " + item[0] }
      puts "Tips: input the index. e.g: 01"
      puts "Message: #{message}".red if message
      print ">>".green
      choose_mode = gets
      choose_index = choose_mode.strip
      if choose_index =~ /\d+/ && choose_index.to_i <= @items.length
        choose = @items[choose_index.to_i - 1]
        break
      else
        message = "Wrong Index, try again."
      end
    end

    choose[1].call
  end
end

class Job
  attr_accessor :status, :intro
  def initialize
    @status = :waiting # :waiting, :processing, :done, :fail
    @intro = self.class.to_s.sub(/Job$/, "").nature_case
  end

  def call
  end

  def rollback
  end
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

class MacOSJobGroup
  def initialize(jobs)
    @title = "=== Rime Deploy ===="
    @queue = []
    jobs.each { |job| @queue << job.new }

    @current_index = 0
    @mode = :auto #:handle
  end

  def print_progress
    system("clear")
    puts @title
    @queue.each_with_index do |job, index|
      job_id = "[%02d]" % (index + 1)
      job_intro = job.intro.to_s.ljust(20).green
      job_status = job.status
      case job_status
      when :waiting
        job_status = job_status.to_s.white
      when :processing
        job_status = job_status.to_s.yellow
      when :done
        job_status = job_status.to_s.green
      end
      job_status = job_status.rjust(15)
      puts "#{job_id} #{job_intro}\t#{job_status}"
    end

    if @current_index < @queue.length
      puts "total: #{@queue.length}".ljust(10)
      puts "Detail " + "-" * 20
    end
  end

  def run_job_with_info_wrapper(current_job)
    print_progress
    begin
      result = current_job.call
      if result == :next
        current_job.status = :done
        @current_index += 1
      else
        # 失败处理
        raise RimeDeployError
      end
      print_progress
    rescue RimeDeployError
      run_jobs_handle
    end
  end

  def guidance
    ChooseSession.new(
      [
        ["Auto mode: Suitable for first-time operation.", -> { run_jobs_auto }],
        ["Handle mode: Decide to execute on your own.", -> { run_jobs_handle }]
      ]
    ).call
  end
  def call
    guidance
  end

  def run_jobs_handle
    handle_jobs = []
    @queue.each_with_index do |job, index|
      job_intro = job.intro.to_s.ljust(20).green
      handle_jobs.push(["#{job_intro}", -> { run_job_with_info_wrapper(job) }])
    end
    ChooseSession.new(handle_jobs).call
  end

  def run_jobs_auto
    print_progress
    while @current_index < @queue.length && @mode == :auto
      current_job = @queue[@current_index]
      current_job.status = :processing
      print_progress
      begin
        result = current_job.call
        if result == :next
          current_job.status = :done
          @current_index += 1
        else
          # 失败处理
          raise RimeDeployError
        end
      rescue RimeDeployError
        @mode = :handle
      end

      print_progress
    end
  end
end

MacOSJobGroup.new(
  [InstallRimeJob, BackupRimeConfigJob, CloneConfigJob, CopyCustomConfigJob]
).call
