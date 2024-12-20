#!/usr/bin/env ruby
# A regular expression that matches a given pattern
# Requirements:
# Your script should output: [SENDER],[RECEIVER],[FLAGS]
# The sender phone number or name (including country code if present)
# The receiver phone number or name (including country code if present)
# The flags that were used
# LOG FILE: TextMe VoIP app `text_messages.log` log file

# GREEDY APPROACH: puts ARGV[0].scan(/\[from:([a-zA-Z0-9+]*)\] \[to:([a-zA-Z0-9+]*)\] \[flags:([0-9\-:]*)\]/).join(",")
# NON-GREEDY APPROACH: puts ARGV[0].scan(/\[from:(.*?)\]\s\[to:(.*?)\]\s\[flags:(.*?)\]/).join(',')
# In a regular expression:
# the `*` quantifier is greedy by default, meaning it will match as many characters as possible.
# the `*?` quantifier is used after each capturing group. The `?` makes the `*` quantifier non-greedy,
# causing it to match as few characters as possible.
# This non-greedy approach ensures that each capturing group captures the smallest possible sequence of characters,
# allowing for more accurate extraction of the sender, receiver, and flags from the input string.

puts ARGV[0].scan(/\[from:(.*?)\]\s\[to:(.*?)\]\s\[flags:(.*?)\]/).join(',')
