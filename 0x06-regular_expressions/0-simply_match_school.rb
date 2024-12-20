#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# This script matches `School` from a string

puts ARGV[0].scan(/School/).join
