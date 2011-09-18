require 'rubygems'
require 'hpricot'
require 'open-uri'

require './model'

# get raw html file to scrape
doc = open('http://www.sky.com/shop/tv/anytime-plus/whats-on/full-movies-list/') { |f| Hpricot(f) }

# movie list is in three columns - subject to change of course
columns = ['#Row1MoviesLeft-Using_Sky_Anytime____TV_on_demand___Sky_VOD',
           '#Row1MoviesCentre-Using_Sky_Anytime____TV_on_demand___Sky_VOD',
           '#Row1MoviesRight-Using_Sky_Anytime____TV_on_demand___Sky_VOD']

# find the movies - separated by newlines and linebreak tags
movies = []
columns.each do |c|
  list = doc.search(c + "//p").inner_html.split("\n<br />")
  list.each do |m|
    movies << m.strip
  end
end

# insert movies
movies.each do |m|
  if Movie.where(:name => m).count.zero?
    Movie.create(:name => m)
    print "#{m}\n"
  end
end