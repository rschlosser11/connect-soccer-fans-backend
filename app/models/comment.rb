class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :fixture
    scope :desc, -> { order('created_at DESC')}
end
