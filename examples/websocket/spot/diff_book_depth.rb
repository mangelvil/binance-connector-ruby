#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require 'eventmachine'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot::WebSocket.new

EM.run do
  onopen = proc { logger.info('connected to server') }
  onmessage = proc { |msg, _type| logger.info(msg) }
  onerror   = proc { |e| logger.error(e) }
  onclose   = proc { logger.info('connection closed') }

  callbacks = {
    onopen: onopen,
    onmessage: onmessage,
    onerror: onerror,
    onclose: onclose
  }

  client.diff_book_depth(symbol: 'btcusdt', speed: '100ms', callbacks: callbacks)
end
