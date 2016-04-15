def buckets
  100
end

def unpack_gems
  1.upto(buckets) do |num|
    dir = "gem_subset_#{num}"
    `ls #{dir}`.strip.split(/\s+/).each do |gem|
      cmd = "gem unpack #{dir}/#{gem} --target=#{dir}"
      puts cmd
      `#{cmd}`
    end
  end
end

# copy_gems_into_subdirectories
unpack_gems

