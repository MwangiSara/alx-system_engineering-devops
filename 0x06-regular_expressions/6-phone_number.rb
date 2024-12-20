#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# The regular expression must match a 10 digit phone number
# `^` asserts the start of the string; `\d` matches any digit (0-9).
# `{10}` specifies that the previous pattern (digit) should occur exactly `10` times.
# `$` asserts the end of the string.

puts ARGV[0].scan(/^\d{10}$/).join
