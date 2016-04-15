def create_directories
  0.upto(99) {|num| `mkdir gems/subset_#{num.to_s.rjust(2, '0')}` }
end

create_directories
