require 'rubygems'
require 'active_record'

dbconfig = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection dbconfig[settings.environment.to_s]

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