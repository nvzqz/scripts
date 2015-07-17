#!/usr/bin/env ruby
# Written by Nikolai Vazquez
# Allows quick change in screenshot path in OS X
# Usage ./chscreen.sh /path/to/screenshot/folder

require 'pathname'

if /darwin/ =~ RUBY_PLATFORM
	if ARGV[0] =~ /-h/ || ARGV.empty?
		puts "Usage: \"#{File.basename $0} /path/to/screenshot/folder\""
	else
		`defaults write com.apple.screencapture location '#{puts Pathname.new(ARGV[0]).realpath}' && killall SystemUIServer`
	end
else
	abort('Error: You are not running OS X!')
end