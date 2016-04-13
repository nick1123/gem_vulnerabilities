require "resolv"

def find_command(directory)
  "find #{directory} -name '*.rb' | grep -v \"/spec/\\|/test/\""
end

def search_for_ip_address_command(directory)
  "#{find_command(directory)} | xargs grep -sn '[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}'"
end

def execute(command)
  `#{command}`
end

def remove_undesirable_lines(command_results)
  break_into_lines(command_results).map { |line|
    # Example line:
    # gem_subset_1/Sipper-1.1.3/sipper/transaction/transaction.rb:10: Td = 32000 # 17.1.1.2
    line.split(/\s+/)  # break each line into pieces
  }.reject { |line_pieces|
    # Example line to reject:
    # gem_subset_1/Sipper-1.1.3/sipper/transaction/transaction.rb:10: # Td = 32000 && 17.1.1.2
    line_pieces.size < 2 || line_pieces[1][0] == '#' # reject line comments
  }.reject { |line_pieces|
    # Example line to reject:
    # gem_subset_1/Sipper-1.1.3/sipper/transaction/transaction.rb:10:# Td = 32000 && 17.1.1.2
    line_pieces[0][-1] == '#' # reject line comments
  }.select { |line_pieces|
    # Example line to reject:
    # gem_subset_1/Sipper-1.1.3/sipper/transaction/transaction.rb:10: Td = 32000 # 17.1.1.2
    line_pieces.any? {|piece| piece =~ Resolv::IPv4::Regex}
  }.map { |line_pieces|
    line_pieces.join(' ')
  }.reject { |line|
    [
      '127.0.0',
      '192.168.1',
      '169.254.169.254',
      '0.0.0.0',
      '1.1.1.1',
      "10.0.0.1",
      'assert_equal',
      'VERSION',
    ].any? { |str|
      line.include?(str)
    }
  }
end

def break_into_lines(command_results)
  command_results.strip.split("\n").map {|line| line.strip }
end

last = 10
last = ARGV[0].to_i if !ARGV[0].nil?

puts (1..last).inject([]) { |results, dir_num|
  results.concat(
    remove_undesirable_lines(
      execute(
        search_for_ip_address_command("gem_subset_#{dir_num}"))))
}.join("\n")



