module RimeDeploy
  class TaskManager
    def initialize
      @osname = nil
      @proxy = nil
      @queue = nil
      @current_job = nil
      check_os
    end

    def call
      require "./lib/os/#{@osname}.job.rb"
      job_group_klass = Object.const_get("#{@osname.capitalize}Jobs")
      @proxy = job_group_klass.new
      @queue = @proxy.queue
      while @queue.size > 0
        @current_job = proxy.queue.pop
        job.result = job.exe
        dispatch_job(result)
      end
    end

    def dispatch_job
      if result == false
        # 任务失败
        puts "The job meets errors. What next do you want?"
        puts "Enter first character : c(ontinue) /e(xit)/ r(etry) /s(kip)"
        next_step = gets
        next_step.strip!

        case next_step.strip!
        when "c"
          puts "contine..."
        when "e"
          puts ""
          puts "Bye~"
          exit 0
        when "r"
          result = @current_job.rollback
          if result
            @queue.push(@current_job)
            @current_job = nil
          else
            puts "#{@current_job.class.to_s} rollback failed."
          end
        end
      end
    end

    private

    def check_os
      case RUBY_PLATFORM
      when /darwin/
        @osname = "mac"
      when /linux/
        @osname = "linux"
      when /unix/
        @osname = "unix"
      when /mswin|win32|mingw|cygwin/
        @osname = "win"
        call_exit
      else
        call_exit
      end
    end

    def call_exit
      puts "We don't support this system."
    end
  end
end
