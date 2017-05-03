require 'rails_helper'
require 'pry'

RSpec.describe LessonsController, type: :controller do

  describe "GET #index" do
    context "when a user is logged in" do
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
        start_time: DateTime.now + 1,
        hours: 1,
        confirmed_at: DateTime.now,
        )}

      before { login_as user1 }

      it "responds with a 200 status" do
        visit lessons_path
        expect(response.status).to eq(200)
      end

      it "creates a lessons" do
        visit lessons_path
        expect(Lesson.count).to eq(1)
      end

      xit 'allows user to see all lessons when logged in'
      #   visit lessons_path
      #   expect(page).to have_content("#{lesson1.skill.title}")
      #   expect(page).to have_content("#{lesson1.teacher.first_name}")
      #   expect(page).to have_content("#{lesson1.student.first_name}")
      # end
    end
  end
end
