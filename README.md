# What it does

Deletes your HN comments automatically that have negative points

# WHY do this 

Ever post a comment you regret? Often these comments have negative points.  If you aren't monitoring the comment closely you will lose your ability to delete the comment -- making it permanent :(

# Install dependencies:
    bundle install 

# How to run it 

To use: 
    ruby run.rb [YOURUSERNAME] [YOURPASSWORD] [MIN_NUMBER_OF_POINTS]

    lets delete it if has less than one point

    ruby run.rb USERNAME PASSWORD 1 

    lets delete it if has less than two points 

    ruby run.rb USERNAME PASSWORD 2

# How to get it to run automatically?

open crontab: 
    crontab -e

    Add this line: 

    * * * * * [path to ruby] run.rb [YOURUSERNAME] [YOURPASSWORD] [MIN_NUMBER_OF_POINTS]
    
On macOS to get the ruby path: 
    which ruby 
    
On macOS if you have problems with crontab with "Operation not permitted" 

    http://osxdaily.com/2018/10/09/fix-operation-not-permitted-terminal-error-macos/
