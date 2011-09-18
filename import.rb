require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'hpricot'
require 'open-uri'

# get raw html file to scrape
# source is http://www.sky.com/shop/tv/anytime-plus/whats-on/full-movies-list/
doc = open('movies.html') { |f| Hpricot(f) }

# movie list is in three columns - subject to change of course
columns = ['#Row1MoviesRight-Using_Sky_Anytime____TV_on_demand___Sky_VOD',
           '#Row1MoviesLeft-Using_Sky_Anytime____TV_on_demand___Sky_VOD',
           '#Row1MoviesCentre-Using_Sky_Anytime____TV_on_demand___Sky_VOD']

# find the movies - separated by newlines and linebreak tags
movies = []
columns.each do |c|
  list = doc.search(c + "//p").inner_html.split("\n<br />")
  list.each do |m|
    movies << m.strip
  end
end

# set up database

# using activerecord and sqlite
db_file = '.movies.db'
db = SQLite3::Database.new('.movies.db')
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => db_file)
class Movie < ActiveRecord::Base; end

# define the movies table (if it doesn't already exist)
if !Movie.table_exists?
  ActiveRecord::Base.connection.create_table(:movies) do |t|
    t.column :name, :string
    t.column :rating, :integer
    t.column :created_at, :timestamp
  end
end

# insert movies
movies.each do |m|
  if Movie.where(:name => m).count.zero?
    Movie.create(:name => m,
                 :rating => nil,
                 :created_at => Time.now)
  end
end