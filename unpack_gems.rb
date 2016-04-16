def unpack_gems
  0.upto(99) do |num|
    dir = "gems/subset_#{num.to_s.rjust(2, '0')}"
    `ls #{dir}`.strip.split(/\s+/).each do |gem|
      cmd = "gem unpack #{dir}/#{gem} --target=#{dir}"
      puts cmd
      `#{cmd}`
    end
  end
end

unpack_gems

