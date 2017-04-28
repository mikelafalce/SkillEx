class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :need_rating


  def need_rating
    if current_user
      unrated_teacher_lessons = current_user.lessons_as_teacher.where(teacher_rating_student:nil).select {|l| l.start_time < DateTime.now if l.start_time}
    elsif unrated_teacher_lessons && unrated_teacher_lessons.count > 0
      redirect_to lesson_rating_path(unrated_teacher_lessons.first)

      # prompt student for rating
    end
  end
end
