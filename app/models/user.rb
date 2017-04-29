class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :avatar
  mount_uploader :avatar, AvatarUploader


  has_many :lessons_as_teacher, class_name: 'Lesson', foreign_key: 'teacher_id'
  has_many :lessons_as_student, class_name: 'Lesson', foreign_key: 'student_id'

  has_many :skills, foreign_key: "teacher_id"

  def lessons
    self.lessons_as_student + self.lessons_as_teacher
  end

end
