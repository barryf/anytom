require 'rubygems'
require 'sqlite3'
require 'active_record'

db_file = '.movies.db'
db = SQLite3::Database.new(db_file)
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => db_file)

class Movie < ActiveRecord::Base; end

# define the movies table (if it doesn't already exist)
if !Movie.table_exists?
  ActiveRecord::Base.connection.create_table(:movies) do |t|
    t.column :name, :string
    t.column :rating, :integer
    t.column :year, :integer
    t.column :runtime, :integer
    t.column :rt_id, :integer    
    t.column :rt_url, :string
    t.column :poster_url, :string
    t.column :summary, :string
  end
end