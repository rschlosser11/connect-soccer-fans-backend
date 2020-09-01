class Fixture < ApplicationRecord
    belongs_to :home_team, class_name: 'Team'
    belongs_to :away_team, class_name: 'Team'
    scope :upcoming, -> { where('event_date > ?', Time.now).order('event_date DESC') }
end