#!/usr/bin/env ruby

#define the RegEx pattern
PATTERN = /\[from:([a-zA-Z\s+:]+|\+|.\d+)\] \[to:(\+?\d+)\] \[flags:([^]]+)\]/

# Extract sender, receiver, and flags
def extract_info(log_entry)
    matches = log_entry.scan(PATTERN)
    if matches.any?
        from = matches[0][0]
        to = matches[0][1]
        flags = matches[0][2]
        puts "#{from},#{to},#{flags}"
    end
end

# Main- processes input and calls extract_info()
if ARGV.length == 1
    log_entry = ARGV[0]
    extract_info(log_entry)
end
