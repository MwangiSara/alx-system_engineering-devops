#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# This script matches any string that starts with
# `h`, ends with `tn`, and have zero or one `b` (0 <= b <= 1)

puts ARGV[0].scan(/hb?tn/).join
