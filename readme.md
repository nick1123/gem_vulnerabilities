./setup.sh
ruby download_gems.rb # Takes ~6 hours running 10 threads


ruby search_for_ip_addresses.rb 100 > results_for_ip_address_search.txt
