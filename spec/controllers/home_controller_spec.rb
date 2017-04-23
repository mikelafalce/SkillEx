require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe "GET /index" do
    
    it "has 'Welcome to SkillEx' on the page" do
      get :index

      expect(response.body).to include("Welcome to SkillEx")
    end

    it "shows a Register and Login button" do
      get :index

      expect(response.body).to include("Login")
      expect(response.body).to include("Register")
    end

  end



end