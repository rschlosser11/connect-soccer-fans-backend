class User < ApplicationRecord
    has_secure_password
    has_many :comments
    validates :email, format: {with: /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\b/}, uniqueness: {case_sensitive: false}, presence: true;
    validates :username, presence: true;
end
