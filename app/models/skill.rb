class Skill < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :lessons

  def self.search(search)
    where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  end
end
