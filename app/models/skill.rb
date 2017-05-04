class Skill < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :lessons

  attr_accessor :avatar
  mount_uploader :avatar, AvatarUploader

  def self.search(search)
    where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  end

  def average_rating
    ratings_array = self.lessons.pluck(:student_rating_teacher) - [nil]
    if ratings_array.length == 0
      return nil
    end
    ratings_array.sum / ratings_array.length.to_d
  end
end
