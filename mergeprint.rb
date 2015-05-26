#!/usr/bin/env ruby
# Written by Nikolai Vazquez
# Prints out all arguments' letters to form the following one
# Two or more arguments are required
#
# Usage:
# ./mergeprint.rb arg1 arg2..last_arg

def ends_with_space?(var)
	return var[var.length - 1] == " "
end

def mergeprint(first_str, second_str)
	start_index = 0
	for i in 0..first_str.length - 1
		last_index = first_str.length - i - 1
		this_str   = first_str[0..last_index]
		if first_str[0..last_index] == second_str[0..last_index]
			start_index = last_index
			break
		elsif !ends_with_space?(this_str)
			puts this_str
		end
	end
	for i in start_index..second_str.length - 2
		this_str = second_str[0..i]
		if !ends_with_space?(this_str)
			puts this_str
		end
	end
end

if ARGV.length > 1
	for i in 1..ARGV.length - 1
		mergeprint(ARGV[i-1], ARGV[i])
		puts ARGV[i] if i == ARGV.length - 1
	end
else
	abort("Two or more arguments are required.")
end