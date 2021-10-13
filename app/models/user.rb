class User < ApplicationRecord
	has_many :followers, class_name: 'Follow', foreign_key: 'follower_id'
	has_many :followees,  class_name: 'Follow', foreign_key: 'followee_id'
	has_many :posts
	has_secure_password
	validates :email, presence: true
	validates :password, presence: true
end
