require 'rubygems'
require 'sinatra'

require 'model'

get '/' do
  @movies = Movie.where('rating is not null and rating > 0').order('rating DESC')
  erb :index
end

get '/details/:movie' do
  @movie = Movie.where(:rt_id => params[:movie])[0]
  erb :details
end