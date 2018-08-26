puts "contents of #{$0}:" # $0 is this file
file_handle = open $0
puts file_handle.read
file_handle.close