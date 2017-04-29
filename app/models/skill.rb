class Skill < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :lessons

  attr_accessor :avatar
  mount_uploader :avatar, AvatarUploader

  def self.search(search)
    where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  end
end
