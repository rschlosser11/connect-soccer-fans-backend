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

url = URI("https://api-football-v1.p.rapidapi.com/v2/teams/league/2")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
request["x-rapidapi-key"] = ENV['RAPID_API_KEY']

response = http.request(request)
body = JSON.parse(response.body)
teams = body['api']['teams']

teams.each do |team| 
    team.transform_keys!(&:to_sym)
    Team.find_or_create_by(team.slice(:team_id, :name, :logo, :country, :founded, :venue_name, :venue_city))
end

User.create(username:'soccerfan1', email:'soccer@me.com', password:'test');
User.create(username:'tim23', email: 'tim@me.com', password:'test')
User.create(username:'123sally', email: 'sally@me.com', password:'test')
User.create(username:'noah43', email: 'noah@me.com', password:'test')
User.create(username:'susan001', email: 'susan@me.com', password:'test')
User.create(username:'1jon4443', email: 'jon@me.com', password:'test')
