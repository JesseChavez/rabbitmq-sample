#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

conn = Bunny.new('amqp://neo:wakeup@10.0.0.160/thematrix')
conn.start

ch = conn.create_channel

q  = ch.queue('greetings')

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"

q.subscribe(block: true, manual_ack: false) do |delivery_info, properties, body|
  puts " [x] Received #{body}, props are: #{properties.inspect}"
  puts delivery_info.consumer.inspect

  # delivery_info.consumer.cancel
end
