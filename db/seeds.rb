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

Player.find_or_create_by(team_id: 39, number: 1, name: 'Bernd Leno', position: 'Goalkeeper', height: '6-3', weight: '183 lbs', birthdate: '3/4/1992', nationality: 'Germany')
Player.find_or_create_by(team_id: 39, number: 26, name: 'Emiliano Martinez', position: 'Goalkeeper', height: '6-5', weight: '194 lbs', birthdate: '9/2/1992', nationality: 'Argentina')
Player.find_or_create_by(team_id: 39, number: 33, name: 'Matt Macey', position: 'Goalkeeper', height: '6-7', weight: '179 lbs', birthdate: '9/9/1994', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 2, name: 'Hector Bellerin', position: 'Defender', height: '5-10', weight: '163 lbs', birthdate: '3/19/1995', nationality: 'Spain')
Player.find_or_create_by(team_id: 39, number: 17, name: 'Cedric Soares', position: 'Defender', height: '5-8', weight: '148 lbs', birthdate: '8/31/1991', nationality: 'Portugal')
Player.find_or_create_by(team_id: 39, number: 3, name: 'Kieran Tierney', position: 'Defender', height: '5-10', weight: '154 lbs', birthdate: '6/5/1997', nationality: 'Scotland')
Player.find_or_create_by(team_id: 39, number: 4, name: 'William Saliba', position: 'Defender', height: '6-4', weight: '187 lbs', birthdate: '3/24/2001', nationality: 'France')
Player.find_or_create_by(team_id: 39, number: 5, name: 'Sokratis', position: 'Defender', height: '6-1', weight: '187 lbs', birthdate: '6/9/1988', nationality: 'Greece')
Player.find_or_create_by(team_id: 39, number: 6, name: 'Gabriel Paulista', position: 'Defender', height: '6-1', weight: '159 lbs', birthdate: '11/26/1990', nationality: 'Brazil')
Player.find_or_create_by(team_id: 39, number: 16, name: 'Rob Holding', position: 'Defender', height: '6-0', weight: '165 lbs', birthdate: '9/20/1995', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 20, name: 'Shkodran Mustafi', position: 'Defender', height: '6-0', weight: '181 lbs', birthdate: '4/17/1992', nationality: 'Germany')
Player.find_or_create_by(team_id: 39, number: 21, name: 'Calum Chambers', position: 'Defender', height: '6-0', weight: '146 lbs', birthdate: '1/20/1995', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 22, name: 'Pablo Mari', position: 'Defender', height: '6-3', weight: '192 lbs', birthdate: '8/31/1993', nationality: 'Spain')
Player.find_or_create_by(team_id: 39, number: 23, name: 'David Luiz', position: 'Defender', height: '6-2', weight: '185 lbs', birthdate: '4/22/1987', nationality: 'Brazil')
Player.find_or_create_by(team_id: 39, number: 31, name: 'Sead Kolasinac', position: 'Defender', height: '6-0', weight: '187 lbs', birthdate: '6/20/1993', nationality: 'Bosnia and Herzegovina')
Player.find_or_create_by(team_id: 39, number: 7, name: 'Bukayo Saka', position: 'Midfielder', height: '5-10', weight: '143 lbs', birthdate: '9/5/2001', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 10, name: 'Mesut Ozil', position: 'Midfielder', height: '5-11', weight: '154 lbs', birthdate: '10/15/1988', nationality: 'Germany')
Player.find_or_create_by(team_id: 39, number: 11, name: 'Lucas Torreira', position: 'Midfielder', height: '5-6', weight: '141 lbs', birthdate: '2/11/1996', nationality: 'Uruguay')
Player.find_or_create_by(team_id: 39, number: 15, name: 'Ainsley Maitland-Niles', position: 'Midfielder', height: '5-10', weight: '157 lbs', birthdate: '8/29/1997', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 25, name: 'Mohamed Elneny', position: 'Midfielder', height: '5-11', weight: '163 lbs', birthdate: '7/11/1992', nationality: 'Egypt')
Player.find_or_create_by(team_id: 39, number: 28, name: 'Joe Willock', position: 'Midfielder', height: '5-10', weight: '157 lbs', birthdate: '8/20/1999', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 29, name: 'Matteo Guendouzi', position: 'Midfielder', height: '6-1', weight: '150 lbs', birthdate: '4/14/1999', nationality: 'France')
Player.find_or_create_by(team_id: 39, number: 34, name: 'Granit Xhaka', position: 'Midfielder', height: '6-0', weight: '181 lbs', birthdate: '9/27/1992', nationality: 'Switzerland')
Player.find_or_create_by(team_id: 39, number: 9, name: 'Alexandre Lacazette', position: 'Forward', height: '5-9', weight: '161 lbs', birthdate: '5/28/1991', nationality: 'France')
Player.find_or_create_by(team_id: 39, number: 12, name: 'Willian', position: 'Forward', height: '5-9', weight: '170 lbs', birthdate: '8/9/1988', nationality: 'Brazil')
Player.find_or_create_by(team_id: 39, number: 14, name: 'Pierre-Emerick Aubameyang', position: 'Forward', height: '6-2', weight: '163 lbs', birthdate: '6/18/1989', nationality: 'Gabon')
Player.find_or_create_by(team_id: 39, number: 19, name: 'Nicolas Pepe', position: 'Forward', height: '6-0', weight: '161 lbs', birthdate: '5/29/1995', nationality: 'Ivory Coast')
Player.find_or_create_by(team_id: 39, number: 24, name: 'Reiss Nelson', position: 'Forward', height: '5-9', weight: '157 lbs', birthdate: '12/10/1999', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 30, name: 'Eddie Nketiah', position: 'Forward', height: '5-9', weight: '154 lbs', birthdate: '5/30/1999', nationality: 'England')
Player.find_or_create_by(team_id: 39, number: 35, name: 'Gabriel Martinelli', position: 'Forward', height: '5-11', weight: '165 lbs', birthdate: '6/18/2001', nationality: 'Brazil')