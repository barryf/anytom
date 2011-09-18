require 'rubygems'
require 'hpricot'

doc = open('movies.html') { |f| Hpricot(f) }

columns = ['#Row1MoviesRight-Using_Sky_Anytime____TV_on_demand___Sky_VOD',
           '#Row1MoviesLeft-Using_Sky_Anytime____TV_on_demand___Sky_VOD',
           '#Row1MoviesCentre-Using_Sky_Anytime____TV_on_demand___Sky_VOD']

movies = []

columns.each do |c|
  list = doc.search(c + "//p").inner_html.split("\n<br />")
  list.each do |m|
    movies << m.strip
  end
end

print movies.inspect