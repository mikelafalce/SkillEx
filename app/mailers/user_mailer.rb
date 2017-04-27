class UserMailer < ApplicationMailer
  default from: 'test@test.com'

  def confirm_lesson(lesson)
    @lesson = lesson
    @recipients = [@lesson.teacher.email, @lesson.student.email]
    mail(to: @recipients, subject: "Lesson confirmation")
  end
end