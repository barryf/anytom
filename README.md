# Anytom

Anytom is a set of scripts to help you decide which films to watch on Sky Anytime+, a video-on-demand (VOD) service run by Sky in the UK. 

The Sky Anytime+ film library is listed on their website in alphabetical order and through the Sky+ box interface, but it's not easy to decide what to watch by just a film's name. 

Anytom queries the Rotten Tomatoes API for critics' ratings, running times, year and synopsis and displays the available films in ratings order, helping you sort the wheat from the chaff.

The name? ANYtime rotten TOMatoes.

## PREREQUISITES

- [Sky Anytime+](http://www.sky.com/shop/tv/anytime-plus/get-it-now/)
- [Rotten Tomatoes API account](http://developer.rottentomatoes.com/member/register)
- Ruby 1.8.7+
- [Bundler](http://gembundler.com/)
- SQLite

## INSTRUCTIONS

1. [Apply for a Rotten Tomatoes API key](http://developer.rottentomatoes.com/member/register).
1. Set an environment variable with your new key, e.g. `export ROTTEN_TOMATOES_KEY=YOUR_KEY`.
1. Clone the repo and `cd` to the folder.
1. Install the gems: `bundle install`.
1. Import the film names from the Sky Anytime+ list: `ruby import.rb`.
1. Import the ratings (and other info) from Rotten Tomatoes: `ruby ratings.rb`.
1. Fire up the Sinatra app: `ruby movies.rb`.
1. Browse to `localhost:9393` in your browser.

## TODO

- Make this a Heroku service (check copyright implications).
- Mobile friendly - no absolutely/fixed DIVs for the details.

## COPYRIGHT

All film data used within this project is copyright (c) Flixster, Inc. Anytime+ is a trademark of BSkyB.

This project is copyright (c) 2011 [Barry Frost](http://barryfrost.com). Suggestions? Fork the project and submit a pull request.

