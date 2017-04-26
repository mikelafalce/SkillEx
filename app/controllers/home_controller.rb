class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @requested_lessons = Lesson.where(teacher: current_user, confirmed_at: nil)
  end
end

