class HomeController < ApplicationController
  before_action :authenticate_user!
  def index

    if current_user
      @current_user_id = current_user.id
    end

    @requested_lessons = Lesson.where(teacher: current_user, confirmed_at: nil)

  end
end

