#!/usr/bin/env ruby
load 'watch.rb'

if !ARGV.empty?
  username=ARGV[0]
  password=ARGV[1]
  min_number_of_points=ARGV[2]
else
  puts ""
  puts "To use: "
  puts "ruby run.rb [YOURUSERNAME] [YOURPASSWORD] [MIN_NUMBER_OF_POINTS]"
  puts ""
  exit
end

# let's login
ret=login(username, password)

# let's get the cookies
cookies = ret[:success]

# let's download the comments
ret=downloadComments(username, cookies )

# let's look for comments that can* be deleted
ids = parseForDeletable(ret.to_s)

# let's take the deletable comments and see if they don't have enough points
ids = parseForBadComments(ids, ret.to_s, min_number_of_points)

if ids.length == 0
  puts "No bad comments...."
else
  # let's nuke the bad comments
  deleteComments(ids, cookies)
end
