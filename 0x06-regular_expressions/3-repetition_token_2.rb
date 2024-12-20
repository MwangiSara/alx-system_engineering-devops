#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# This script matches any string that starts with
# `hb`, ends with `n`, and have one or more `t` (1 <= t <= infinity)

puts ARGV[0].scan(/hbt+n/).join
