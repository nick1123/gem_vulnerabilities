def buckets
  100
end

def full_gem_list
  @full_gem_list ||= `ls all_gems`.strip.split(/\s+/)
end

def gems_per_bucket
  (full_gem_list.size.to_f / buckets).ceil
end

def copy_gems_into_subdirectories
 full_gem_list.shuffle.each_slice(gems_per_bucket).with_index do |gems, index|
    gems.each do |gem|
      cmd = "cp all_gems/#{gem} gem_subset_#{index + 1}"
      puts cmd
      `#{cmd}`
    end
  end
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

