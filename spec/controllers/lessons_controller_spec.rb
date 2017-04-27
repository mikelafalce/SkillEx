require 'rails_helper'
require 'pry'

RSpec.describe LessonsController, type: :controller do
  describe "GET #index" do
    context "when a user is logged in" do
      context "when user has created a lesson" do

        let!(:user1) {User.create(
          first_name: "jyn",
          last_name: "k",
          email: "jyn@com",
          password: '123456'
          )}
        let!(:skill1) {Skill.create(
          teacher: user1,
          title: "Korean",
          description: "grammar",
          )}
        let!(:lesson1) {Lesson.create(
          skill: skill1,
          teacher: user1,
          student: user1,
          )}

        it "responds with a 200 status" do

          get :index
          visit lessons_path
          visit '/lessons'

          fill_in 'Email', with: 'jyn@com'
          fill_in 'Password', with: '123456'
          fill_in 'Password Confirmation', with: '123456'
          click_button 'Log In'
          expect(response.status).to eq(200)
        end

        it 'redirects to login if not logged in' do
        end

        it 'allows user to see all lessons when logged in' do
        end

        it "sets user's sent posts" do

          get :index
          expect(Lesson.count).to eq(1)
        end
      end
    end
  end
end
