require 'rubygems'
require 'json'
require 'net/http'

require 'model'

rt_key = ENV['ROTTEN_TOMATOES_KEY'] ||= ''
rt_url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=#{rt_key}&q="

# get each of the anytime movies from the db
Movie.all.each do |movie|
  
  # if we don't have a rt_id then we need to try to find details from rotten tomatoes
  if movie.rt_id == nil
    
    # fetch and parse the json
    url = rt_url + URI.escape(movie.name)
    resp = Net::HTTP.get_response(URI.parse(url))
    
    # did we get a successful response? if so, try to parse
    if resp.code == '200'
      data = JSON.parse(resp.body)
      
      # did RT find the film?
      if data['total'] != 0     
      
        # use the aggregated critics' score
        movie.rating = data['movies'][0]['ratings']['critics_score'].to_i
        movie.year = data['movies'][0]['year'].to_i
        movie.runtime = data['movies'][0]['runtime'].to_i
        movie.rt_id = data['movies'][0]['id']
        movie.rt_url = data['movies'][0]['links']['alternate']
        movie.poster_url = data['movies'][0]['posters']['detailed']
        movie.summary = data['movies'][0]['critics_consensus']
        movie.save
      
        # successful find and insert to show film and rating
        print "#{movie.name} - #{movie.rating}\n"
      else
        # didn't find the film so say so
        print "#{movie.name} - (not found)\n"
      end
    
    else
      print "Failed to fetch JSON: #{resp.inspect}"
      exit
    end    

    # wait 20ms - only allowed 10 req/s so restrict calls to 5/s
    sleep(0.2)
  end  
end