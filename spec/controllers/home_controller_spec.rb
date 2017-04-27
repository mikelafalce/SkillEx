require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  describe 'Homepage' do

    let!(:user1) {User.create(
      first_name: "jyn",
      last_name: "k",
      email: "jyn@com",
      )}

    it "has 'Welcome to SkillEx' on the page" do
      visit '/'
      page.has_content?("Welcome to SkillEx")
    end
    it "shows a Register and Login button" do
      visit root_path
      page.has_content?("Login")
      page.has_content?("Register")
    end

    before(:each) do
      @user = User.find(first_name: "jyn")
      @user.logout
    end
  end
end
