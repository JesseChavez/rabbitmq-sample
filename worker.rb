#!/usr/bin/env ruby
# encoding: utf-8

require 'sneakers'
require 'json'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every('10s', overlap: false) do
  puts 'Hello... Rufus'
end

Sneakers.configure  heartbeat: 2,
                    amqp: 'amqp://neo:wakeup@192.168.1.5',
                    vhost: '/thematrix',
                    exchange: 'sneakers',
                    exchange_type: :direct,
                    workers: 2, # Number of per-cpu processes to run
                    log: 'sneakers.log',
                    pid_path: 'sneakers.pid'

# sample
class Processor
  include Sneakers::Worker
  from_queue :meeting

  def work(json_msg)
    msg = JSON.parse(json_msg)
    if msg['language'] == 'spanish'
      puts "processor: #{msg['message']} at #{msg['time']}"
    end

    ack!
  end
end
