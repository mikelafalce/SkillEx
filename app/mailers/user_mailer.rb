class UserMailer < ApplicationMailer
  default from: 'skillex.bravo@gmail.com'

  def confirm_lesson(lesson)
    @lesson = lesson
    @recipients = [@lesson.teacher.email, @lesson.student.email]
    mail(to: @recipients, subject: "Lesson confirmation")
  end
end