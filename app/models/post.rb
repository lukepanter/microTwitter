class Post < ApplicationRecord
  belongs_to :user
  def attribute_sort(b)
    self.attribute <=> b.attribute
  end
end
