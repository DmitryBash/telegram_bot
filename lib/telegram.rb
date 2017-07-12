require 'telegram/bot'
require 'dotenv/load'
require './lib/kino.rb'
require './lib/request_handler.rb'

class Message
  def initialize
    @token = ENV["api_telegram_token"]
    start_listening
  end

  def start_listening
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        RequestHandler.new(message, bot)
      end
    end
  end
end
