class HelloWorldController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
      @current_user_id = current_user.id
    end
  end
end
