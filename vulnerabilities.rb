require "resolv"

def find_command(directory)
  "find #{directory} -name '*.rb' | grep -v \"/spec/\\|/test/\""
end

def search_for_net_http_command(directory)
  "#{find_command(directory)} | xargs grep -n Net::HTTP"
end

def search_for_http_url_command(directory)
  "#{find_command(directory)} | xargs grep -ni \"http://\""
end

def search_for_ip_address_command(directory)
  "#{find_command(directory)} | xargs grep -n '[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}'"
end

def execute(command)
  `#{command}`
end

def look_for_urls(directory)
  execute(search_for_http_url_command(directory))
end

def remove_undesirable_lines(command_results)
  break_into_lines(command_results).map { |line|
    line.split(/\s+/)  # break each line into pieces
  }.reject { |line_pieces|
    line_pieces[1][0] == '#' # reject line comments
  }.reject { |line_pieces|
    line_pieces[0][-1] == '#' # reject line comments
  }.select { |line_pieces|
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
  }.join("\n")
end

def break_into_lines(command_results)
  command_results.strip.split("\n").map {|line| line.strip }
end

# puts execute(search_for_net_http_command('gem_subset_1'))
# puts look_for_urls('gem_subset_1')
puts remove_undesirable_lines(
       execute(
         search_for_ip_address_command('gem_subset_1')))

