class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :lessons_as_teacher, class_name: 'Lesson', foreign_key: 'teacher_id'
  has_many :lessons_as_student, class_name: 'Lesson', foreign_key: 'student_id'

  has_many :skills, foreign_key: "teacher_id"
end
