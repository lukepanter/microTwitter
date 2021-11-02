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
    return Like.where("post_id = #{self.id}")
  end
end
