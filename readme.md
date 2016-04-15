./setup.sh
ruby download_gems.rb # Takes ~20 hours running 10 threads to download
115k gems

# run this to monitor how gems were download so far
while :; do clear; ls | grep "\.gem" | wc -l; sleep 60; done

# move the gems into gems/all
for f in `ls | grep "\.gem"` ; do mv $f gems/all/ ; done

ruby search_for_ip_addresses.rb 100 > results_for_ip_address_search.txt
