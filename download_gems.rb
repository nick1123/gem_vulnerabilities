require 'thread'

gems = IO.readlines("remote_gems_list.txt").shuffle

gem_names = gems.map {|gem| gem.split(/\s+/)[0] }

work_q = Queue.new
gem_names.each{|x| work_q.push x }

workers = (0..9).map do
  Thread.new do
    begin
      while gem_name = work_q.pop(true)
        puts `gem fetch #{gem_name}`
      end
    rescue ThreadError
    end
  end
end; "ok"
workers.map(&:join); "ok"

