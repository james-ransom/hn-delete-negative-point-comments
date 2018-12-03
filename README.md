# What it does

Deletes your HN comments automatically that have negative points

# WHY do this 

Ever post a comment you regret? Often these comments have negative points.  If you aren't monitoring the comment closely you will lose your ability to delete the comment -- making it permanent :(

# Install dependencies:
    bundle install 

# How to run it 

To use: 

    ruby run.rb [YOURUSERNAME] [YOURPASSWORD] [MIN_NUMBER_OF_POINTS]

let's delete comments less than one point

    ruby run.rb USERNAME PASSWORD 1 

let's delete comments less than two points 

    ruby run.rb USERNAME PASSWORD 2

# How to get it to run automatically?

add rvm properties to your cronjob file [backup your crontab first!] 

    rvm cron setup; 
    
open crontab in your Terminal: 

    crontab -e

Add this line: 

    * * * * * cd [path to code source]; ruby run.rb [YOURUSERNAME] [YOURPASSWORD] [MIN_NUMBER_OF_POINTS]

Example
    
    cd /Users/username/hn-delete-negative-point-comments; ruby run.rb throwaway203821 throwawaypassword 1  >> /tmp/delete.log
    
On macOS to get the ruby path, type in your Terminal: 
    
    which ruby 
    
On macOS if you have problems with crontab with "Operation not permitted" 

    http://osxdaily.com/2018/10/09/fix-operation-not-permitted-terminal-error-macos/
    
For more help with crontab 
    
    https://ole.michelsen.dk/blog/schedule-jobs-with-crontab-on-mac-osx.html

For more help with rvm and cron 

    https://stackoverflow.com/questions/5680561/need-to-set-up-rvm-environment-prior-to-every-cron-job
    
# Watch it run (Assuming you pipe it to /tmp/delete.log)

    $ tail -f /tmp/delete.log
    No bad comments....
    No bad comments....
    No bad comments....
    No bad comments....
    Deleting comment: 18588594
    No bad comments....


# Tests

    ruby test.rb 
  
# Git Stars appreciated

This was just a funny idea to keep me typing ruby for a few hours.
    
 
![alt text](https://www.opendoctor.io/images/giphy.gif)
