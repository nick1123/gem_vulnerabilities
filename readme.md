Getting started

    ./setup.sh

Download 115,000 gems. Takes ~20 hours running 10 threads to download

    ruby download_gems.rb

Run this to monitor how gems were download so far

    while :; do clear; ls | grep "\.gem" | wc -l; sleep 60; done

Move the gems into gems/all

    for f in `ls | grep "\.gem"` ; do mv $f gems/all/ ; done

Verify the gems are in gems/all

    ls gems/all | wc -l

Make sub directories

    ruby directory_generator.rb

Copy gems into subdirectories.  Took me ~24 minutes

    ruby copy_gems_into_subdirectories.rb

Verify the number of files in each subdirectory

    for f in `ls gems/ | grep subset` ; do echo $f ": " `ls gems/$f | wc -l` files ; done



ruby search_for_ip_addresses.rb 100 > results_for_ip_address_search.txt
