class Skill < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_many :lessons
  include PgSearch
    multisearchable :against => [:title, :description]
end
