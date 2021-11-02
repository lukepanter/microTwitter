class User < ApplicationRecord
	has_many :followers, class_name: 'Follow', foreign_key: 'follower_id'
	has_many :followees,  class_name: 'Follow', foreign_key: 'followee_id'
	has_many :posts
	has_many :likes
	has_secure_password
	validates :email, presence: true
	validates :password, presence: true
	def get_feed_post
		pfeed = Array.new
  		listOfFollower = self.followees
  		listOfFollower.each do |follower|
    		tId = follower.follower_id 
    		tUser = User.find_by(id: tId)
    		tUser.posts.each do |post|
      			pfeed.push(post)
    		end
  		end
  		self.posts.each do |post|
    		pfeed.push(post)
  		end
  		pfeed.sort! { |a,b| a.updated_at <=> b.updated_at }.reverse!
  		return pfeed
	end
end
