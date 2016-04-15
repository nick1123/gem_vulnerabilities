Getting started

    ./setup.sh

Download 115,000 gems. Takes ~20 hours running 10 threads to download

    ruby download_gems.rb

Run this to monitor how gems were download so far

    while :; do clear; ls | grep "\.gem" | wc -l; sleep 60; done

Move the gems into gems/all

    for f in `ls | grep "\.gem"` ; do mv $f gems/all/ ; done

Make sub directories

    ruby directory_generator.rb





ruby search_for_ip_addresses.rb 100 > results_for_ip_address_search.txt
