require 'rails_helper'
require 'pry'

RSpec.describe "Home" do
  # render_views

  describe 'Homepage' do
    context 'before logged in' do

      it 'requires to log in' do
        visit root_path
        expect(page.html).to match("You need to sign in or sign up before continuing.")
      end

      it "shows a Register and Login button" do
        visit root_path
        expect(page.html).to match("Login")
        expect(page.html).to match("Register")
      end
    end

    context 'after user is logged in' do
      let!(:user1) {User.create(
        first_name: "jyn",
        last_name: "k",
        email: "jyn@com",
        password: '123456'
        )}
      before { login_as user1 }

      # mocking login
      it "welcomes the user" do
        visit root_path
        expect(page).to have_content("Welcome to SkillEx, #{user1.first_name}")
      end

      xit "should log the user out"
        # before { logout user1 }
        # visit root_path
        # expect(user1).to be_nil
    end
  end
end
