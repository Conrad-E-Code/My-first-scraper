require 'httparty'
require 'nokogiri'
require 'date'

class Scraper

attr_accessor :parse_page

    def initialize
    doc = HTTParty.get "http://store.nike.com/us/en_us/pw/mens-nikeid-lifestyle-shoes/1k9Z7puZoneZoi3"
    @parse_page ||= Nokogiri::HTML doc
    end
    def name_and_price 
        d = DateTime.now

        list = parse_page.css("#Wall > div > div.results__body > div.product-grid.css-1hl0l1w > main > section > div")
        names_plus_prices = list.children.map {|child| nameprice =  {
            price: child.css(".product-card__price").text,
             name:  child.css(".product-card__link-overlay").text,
             quoted_at: "#{d.strftime("%d/%m/%Y %H:%M")}"
        }}
    end

    scraper = Scraper.new
    names_plus_prices = scraper.name_and_price
    puts names_plus_prices
end