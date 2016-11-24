#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

# connecting to the RabbitMQ Server
# be aware of virtual host names
# '/thematrix' and 'thematrix' are not the same
conn = Bunny.new(
  host: '10.0.0.160', vhost: 'thematrix', user: 'neo', password: 'wakeup'
)
conn.start

# channel creation
ch = conn.create_channel

# create queue if not exsistent
q = ch.queue('greetings')

# setting a exchange type
x = ch.default_exchange

msg = "Hello World! at #{Time.now}"

x.publish(msg, routing_key: q.name)

puts " queued [x]: #{msg}"

# close connection
conn.close
