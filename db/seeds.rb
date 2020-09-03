# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'uri'
require 'net/http'
require 'openssl'

teams_url = URI("https://api-football-v1.p.rapidapi.com/v2/teams/league/2")

teams_http = Net::HTTP.new(teams_url.host, teams_url.port)
teams_http.use_ssl = true
teams_http.verify_mode = OpenSSL::SSL::VERIFY_NONE

teams_request = Net::HTTP::Get.new(teams_url)
teams_request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
teams_request["x-rapidapi-key"] = ENV['RAPID_API_KEY']

teams_response = teams_http.request(teams_request)
teams_body = JSON.parse(teams_response.body)
teams = teams_body['api']['teams']

teams.each do |team| 
    team.transform_keys!(&:to_sym)
    Team.find_or_create_by(team.slice(:team_id, :name, :logo, :country, :founded, :venue_name, :venue_city))
end

fixtures_url = URI("https://api-football-v1.p.rapidapi.com/v2/fixtures/league/2")

fixtures_http = Net::HTTP.new(fixtures_url.host, fixtures_url.port)
fixtures_http.use_ssl = true
fixtures_http.verify_mode = OpenSSL::SSL::VERIFY_NONE

fixtures_request = Net::HTTP::Get.new(fixtures_url)
fixtures_request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
fixtures_request["x-rapidapi-key"] = ENV['RAPID_API_KEY']

fixtures_response = fixtures_http.request(fixtures_request)
fixtures_body = JSON.parse(fixtures_response.body)
fixtures = fixtures_body['api']['fixtures']

fixtures.each do |fixture|
    fixture.transform_keys!(&:to_sym)
    Fixture.find_or_create_by(fixture.slice(:fixture_id, :event_date, :statusShort, :elapsed, :venue, :referee, :goalsHomeTeam, :goalsAwayTeam).merge(away_team: Team.find_by(team_id: fixture[:awayTeam]['team_id']), home_team: Team.find_by(team_id: fixture[:homeTeam]['team_id'])))
end

fix = Fixture.find_or_create_by(fixture_id: 111111110, event_date: "2020-09-12 15:00:00", statusShort: "Up", elapsed: 0, venue: "Craven Cottage", referee: nil, home_team_id: 27, away_team_id: 39, goalsHomeTeam: 0, goalsAwayTeam: 0)
Fixture.find_or_create_by(fixture_id: 111111111, event_date: "2020-09-12 15:00:00", statusShort: "Up", elapsed: 0, venue: "London Stadium", referee: nil, home_team_id: 36, away_team_id: 34, goalsHomeTeam: 0, goalsAwayTeam: 0)

User.create(username:'soccerfan1', email:'soccer@me.com', password:'test');
User.create(username:'tim23', email: 'tim@me.com', password:'test')
User.create(username:'123sally', email: 'sally@me.com', password:'test')
User.create(username:'noah43', email: 'noah@me.com', password:'test')
User.create(username:'susan001', email: 'susan@me.com', password:'test')
User.create(username:'1jon4443', email: 'jon@me.com', password:'test')

Comment.find_or_create_by(text: 'great game!', user_id: 2, fixture: fix)
Comment.find_or_create_by(text: 'GO ARSENAL!!!!!!', user_id: 1, fixture: fix)
Comment.find_or_create_by(text: "Hopefully our defense is solid", user_id: 3, fixture: fix)
Comment.find_or_create_by(text: 'Here we goooooo!', user_id: 5, fixture: fix)
Comment.find_or_create_by(text: 'Come on you gunners!', user_id: 3, fixture: fix)
Comment.find_or_create_by(text: 'Fulham forever! :D', user_id: 4, fixture: fix)
Comment.find_or_create_by(text: "Hey, y'all!", user_id: 2, fixture: fix)
Comment.find_or_create_by(text: 'Oh noooooooo, typical!', user_id: 4, fixture: fix)
Comment.find_or_create_by(text: 'GOOOOOOAAAAAALLLLLL! AUBA!!!!!', user_id: 2, fixture: fix)

