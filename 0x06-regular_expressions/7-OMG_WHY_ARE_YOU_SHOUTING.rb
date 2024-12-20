#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# The regular expression must be only matching: `capital letters`

puts ARGV[0].scan(/[A-Z]+/).join
