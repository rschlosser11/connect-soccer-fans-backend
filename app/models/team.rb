class Team < ApplicationRecord
    validates :team_id, uniqueness: true 
end