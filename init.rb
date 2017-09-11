require './lib/telegram.rb'

class Tele
  def initialize
    @bot = Message.new
  end
end

Tele.new
