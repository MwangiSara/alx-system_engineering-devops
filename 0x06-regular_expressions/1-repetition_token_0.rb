#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# This script matches any string that starts with
# `hb`, ends with `n`, and have between 2 and 5(inclusive) t's

puts ARGV[0].scan(/hbt{2,5}n/).join
