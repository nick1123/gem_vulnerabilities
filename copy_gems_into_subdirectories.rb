def full_gem_list
  `ls gems/all`.strip.split(/\s+/)
end

def gems_per_bucket
  (full_gem_list.size.to_f / 100).ceil
end

def copy_gems_into_subdirectories
 full_gem_list.shuffle.each_slice(gems_per_bucket).with_index do |gems, index|
    gems.each do |gem|
      cmd = "cp gems/all/#{gem} gems/subset_#{index.to_s.rjust(2, '0')}/"
      puts cmd
      `#{cmd}`
    end
  end
end

copy_gems_into_subdirectories

