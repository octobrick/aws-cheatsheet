#!/usr/local/bin/ruby19

require 'rubygems'
require 'tzinfo'
require 'net/ssh'

# Get Pacific Time zone
TZ = TZInfo::Timezone.get('PST8PDT')

@USER = 'alan'
@debug = true
# List of PC and Mac Addresses
pc_arr   = [2,3,4,5,6,7,9,11,13,14]
mac_arr  = [22,23,24,25,26,28,29,30]

kk = Hash.new
output = Hash.new

num_thread = pc_arr.size
thread_list = []
1.upto(num_thread.to_i).each do |t|
  thread_list << Thread.new { #add a new thread
   # insert useful ssh commands below
   puts "PC-#{ pc_arr[t-1]}" if @debug
   pc = pc_arr[t-1]

  output[t] = `ssh -o ConnectTimeout=10 alan@123.123.10.#{pc} "hostname" 2>&1`
  kk[t] = output[t].match(/Operation timed out/)
  tt = Time.now
  if kk[t].nil?
    puts "PC-#{pc} #{tt.strftime('%Y-%m-%d_%H-%M-%S')} UTC:SSH GOOD!"
  else
    puts " ====>  PC-#{pc} #{tt.strftime('%Y-%m-%d_%H-%M-%S')} UTC:SSH DOWN!!!"
  end

 }
end
thread_list.each {|x| x.join} #wait for each thread to finish

num_thread = mac_arr.size
thread_list = []
1.upto(num_thread.to_i).each do |t|
  thread_list << Thread.new { #add a new thread
   # insert useful ssh commands below
   puts "Mac-#{ mac_arr[t-1]}" if @debug
   mac = mac_arr[t-1]

  output[t] = `ssh -o ConnectTimeout=10 alan@123.123.10.#{mac} "hostname" 2>&1`
  kk[t] = output[t].match(/Operation timed out/)
  tt = Time.now
  if kk[t].nil?
    puts "Mac-#{mac} #{tt.strftime('%Y-%m-%d_%H-%M-%S')} UTC:SSH GOOD!"
  else
    puts " ====>  Mac-#{mac} #{tt.strftime('%Y-%m-%d_%H-%M-%S')} UTC:SSH DOWN!!!"
  end

 }
end
thread_list.each {|x| x.join} #wait for each thread to finish
