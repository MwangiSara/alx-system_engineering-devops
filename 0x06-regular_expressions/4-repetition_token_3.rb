#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# This script matches any string that starts with
# `hb`, ends with `n`, and have zero or more `t` (0 <= t <= infinity)

puts ARGV[0].scan(/hbt*n/).join
