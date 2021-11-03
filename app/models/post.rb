class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  def attribute_sort(b)
    self.attribute <=> b.attribute
  end

  def get_count_like
    count = Like.where("post_id = #{self.id}").size()
  end
  def get_user_like
    likeName = Array.new
    likeUser =Like.where("post_id = #{self.id}")
    likeUser.each do |like|
      userLike = User.find_by(id: like.user_id)
      likeName.append(userLike.name)
    end
    return likeName 
  end
end
