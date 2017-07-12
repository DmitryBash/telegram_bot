require 'mechanize'

class Film
  attr_accessor :film_title, :kinopoisk_rating, :kinopoisk_link, :film_description
  def initialize
    @agent = Mechanize.new
    begin
      @page = @agent.get("http://www.kinopoisk.ru/top/lists/1/filtr/all/sort/order/perpage/100/page/#{rand(5)}/")
    rescue SocketError, Net::HTTP::Persistent::Error
      abort "Не удалось добраться до Кинопоиска. Проверьте сеть."
    end
    assign_all_film_variables
  end

  def assign_all_film_variables
    @tr_tag = @page.search("//tr[starts-with(@id, 'tr_')]").to_a.sample
    @film_title =   @tr_tag.search("a[@class='all']").text
    @kinopoisk_rating = @tr_tag.search("span[@class = 'all']").text
    @kinopoisk_link = "http://kinopoisk.ru/film/#{@tr_tag.attributes["id"].to_s.gsub(/tr_/,'')}/"
    @film_description = @tr_tag.search("span[@class='gray_text']")[0].text
  end
end
