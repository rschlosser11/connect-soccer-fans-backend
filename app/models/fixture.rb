class Fixture < ApplicationRecord
    belongs_to :home_team, class_name: 'Team'
    belongs_to :away_team, class_name: 'Team'
    scope :upcoming, -> { where('event_date > ?', Time.now).order('event_date DESC') }

    def self.find_fixtures_by_team(team_id)
        self.where(away_team_id: team_id).or(self.where(home_team_id: team_id))
    end
end