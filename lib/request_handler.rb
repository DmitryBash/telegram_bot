class RequestHandler
  def initialize(receiver, bot)
    @message = receiver
    @bot = bot
    @film = Film.new
    handle_message
  end

  def handle_message
    case @message.text
    when '/start'
      start_sender(@message, @bot)
    when '+'
      plus_sender(@message, @bot)
      choice_list(@message, @bot)
    end
  end

  private

  def start_sender(message, bot)
    bot.api.send_message(
        chat_id: message.chat.id,
        text: "Дороу, #{message.from.first_name}, что попросить бота выбрать тебе фильм, нажми '+'"
        )
  end

  def plus_sender(message, bot)
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "Название фильма: #{@film.film_title}
             #{@film.film_description}
             Рейтинг: #{@film.kinopoisk_rating}"
      )
  end

  def choice_list(message, bot)
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Страница фильм Кинопоиске', url: @film.kinopoisk_link),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Смотреть фильм онлайн на filmix', url: "https://filmix.me/search/#{@film.film_title}"),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Смотреть фильм онлайн на gidonline', url: "http://gidonline.club/?s=#{@film.film_title}&submit=Поиск"),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Найти фильм ну РуТрекере (нужна авторизация там)', url: "http://rutracker.org/forum/tracker.php?nm=#{@film.film_title}"),
    ]
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    bot.api.send_message(chat_id: message.chat.id, text: "Выбери ссылку по душе или продолжи поиск фильмов '+'", reply_markup: markup)
  end
end
