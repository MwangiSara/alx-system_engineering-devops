#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# This script matches any string that starts with `h`,
# ends with `n` and have one character in between

puts ARGV[0].scan(/^h.n$/).join
