#!/usr/bin/env ruby

require 'rubygems'
require 'chatterbot/dsl'

#This is some starter code for your bot. You will need to keep
# this file and do_scrum.yml together to run your bot. The .yml file
# will hold your authentication credentials and help track certain
# information about what tweets the bot has seen so far.
#
# The code here is a basic starting point for a bot. It shows you the
# different methods you can use to get tweets, send tweets, etc. It
# also has a few settings/directives which you will want to read
# about, and comment or uncomment as you see fit.
#


#
# These lines here are just to make sure you edit this file before
# trying to run your bot. You can safely remove them once you've
# looked through this file.
#
#puts "========================"
#puts "========================"
#puts "========================"
#puts "\n\n\n"

#puts "Hey there! You should open do_scrum.rb and take a look before running this script."

#puts "\n\n\n"
#exit



#
# Placing your security credentials right in a script like this is
# handy, but potentially dangerous, especially if your code is
# publicly available on github or somewhere else. However, if it is
# convenient for you to have your authentication data here, you can
# uncomment the lines below, and copy your configuration data from
# do_scrum.yml into the commands.
#
# consumer_key 'consumer_key'
# consumer_secret 'consumer_secret'
#
# secret 'secret'
# token 'token'


# Enabling **debug_mode** prevents the bot from actually sending
# tweets. Keep this active while you are developing your bot. Once you
# are ready to send out tweets, you can remove this line.
#debug_mode

# Chatterbot will keep track of the most recent tweets your bot has
# handled so you don't need to worry about that yourself. While
# testing, you can use the **no_update** directive to prevent
# chatterbot from updating those values. This directive can also be
# handy if you are doing something advanced where you want to track
# which tweet you saw last on your own.
#no_update

# remove this to get less output when running your bot
verbose

# The blocklist is a list of users that your bot will never interact
# with. Chatterbot will discard any tweets involving these users.
# Simply add their twitter handle to this list.
blocklist "abc", "def"

# If you want to be even more restrictive, you can specify a
# 'safelist' of accounts which your bot will *only* interact with. If
# you uncomment this line, Chatterbot will discard any incoming tweets
# from a user that is not on this list.
# safelist "foo", "bar"

# Here's a list of words to exclude from searches. Use this list to
# add words which your bot should ignore for whatever reason.
exclude "hi", "spammer", "junk"

# Exclude a list of offensive, vulgar, 'bad' words. This list is
# populated from Darius Kazemi's wordfilter module
# @see https://github.com/dariusk/wordfilter
exclude bad_words

# This will restrict your bot to tweets that come from accounts that
# are following your bot. A tweet from an account that isn't following
# will be rejected
#only_interact_with_followers

#
# Specifying 'use_streaming' will cause Chatterbot to use Twitter's
# Streaming API. Your bot will run constantly, listening for tweets.
# Alternatively, you can run your bot as a cron/scheduled job. In that
# case, do not use this line. Every time you run your bot, it will
# execute once, and then exit.
#
#use_streaming

#
# Here's the fun stuff!
#

# Searches: You can do all sorts of stuff with searches on Twitter.
# However, please note, interacting with users who don't follow your
# bot is very possibly:
#  - rude
#  - uncool
#  - likely to get your bot suspended
#
# Still here? Hopefully it's because you're going to do something cool
# with the data that doesn't bother other people. Hooray!
#
#search "chatterbot" do |tweet|
#  # here's the content of a tweet
#  puts tweets.text
#end

#
# this block responds to mentions of your bot
#
#replies do |tweet|
#  # Any time you put the #USER# token in a tweet, Chatterbot will
#  # replace it with the handle of the user you are interacting with
#  reply "Yes #USER#, you are very kind to say that!", tweet
#end

#
# this block handles incoming Direct Messages. if you want to do
# something with DMs, go for it!
# 
# direct_messages do |dm|
 # puts "DM received: #{dm.text}"
 # direct_message "Hi there, I got your message", dm.sender
# end

#
# Use this block to get tweets that appear on your bot's home timeline
# (ie, if you were visiting twitter.com) -- using this block might
# require a little extra work but can be very handy
#
# home_timeline do |tweet|
#  puts tweet.inspect
# end

#
# Use this block if you want to be notified about new followers of
# your bot. You might do this to follow the user back.
#
# NOTE: This block only works with the Streaming API. If you use it,
# chatterbot will assume you want to use streaming and will
# automatically activate it for you.
#
# followed do |user|
#  puts user.inspect
# end

#
# Use this block if you want to be notified when one of your tweets is
# favorited. The object passed in will be a Twitter::Streaming::Event
# @see http://www.rubydoc.info/gems/twitter/Twitter/Streaming/Event
#
# NOTE: This block only works with the Streaming API. If you use it,
# chatterbot will assume you want to use streaming and will
# automatically activate it for you.
#
# favorited do |event|
#  puts event.inspect
# end

#
# Use this block if you want to be notified of deleted tweets from
# your bots home timeline. The object passed in will be a
# Twitter::Streaming::DeletedTweet
# @see http://www.rubydoc.info/gems/twitter/Twitter/Streaming/DeletedTweet
#
# NOTE: This block only works with the Streaming API. If you use it,
# chatterbot will assume you want to use streaming and will
# automatically activate it for you.
#
#deleted do |tweet|
#
#end
  
SOURCE = "random_daily_scrum_tips.txt"
# You may need to add the path to the source file so that cron can find it. Eg. /home/sash/daily_scrum_twitter/random_daily_scrum_tips.txt


bot.config[:index] ||= 0

if ENV["FORCE_INDEX"]
  bot.config[:index] = ENV["FORCE_INDEX"].to_i
end
 
data = File.read(SOURCE).split(/\n/)

source_pre = data[ bot.config[:index] ]

final = "#{source_pre} #Agile #Scrum"

tweet(final)

if bot.config[:index] == 121 then
	bot.config[:index] = nil
else
	bot.config[:index] += 1
end



