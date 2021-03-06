class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :need_rating


  def need_rating
    if current_user
      unconfirmed_lessons = current_user.lessons.select {|l| l.confirmed_at == nil}
      unconfirmed_lessons_past_due = unconfirmed_lessons.select {|l| l.start_time < DateTime.now}
      unconfirmed_lessons_past_due.each do |lesson|
        lesson.destroy
      end

      unrated_teacher_lessons = current_user.lessons_as_teacher.where(teacher_rating_student:nil).select {|l| l.start_time + l.hours*60*60 < DateTime.now if l.start_time}
      unrated_student_lessons = current_user.lessons_as_student.where(student_rating_teacher:nil).select {|l| l.start_time + l.hours*60*60 < DateTime.now if l.start_time}
    end

    if unrated_teacher_lessons && unrated_teacher_lessons.count > 0
      redirect_to lesson_rating_path(unrated_teacher_lessons.first), notice: 'Please rate your lesson before continuing.'
    elsif unrated_student_lessons && unrated_student_lessons.count > 0
      redirect_to lesson_rating_path(unrated_student_lessons.first), notice: 'Please rate your lesson before continuing.'
    end
  end

end
