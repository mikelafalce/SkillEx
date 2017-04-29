class Lesson < ApplicationRecord
  belongs_to :skill
  belongs_to :teacher, class_name: 'User'
  belongs_to :student, class_name: 'User'

  def rating
  end

  def review
  end
  
end
