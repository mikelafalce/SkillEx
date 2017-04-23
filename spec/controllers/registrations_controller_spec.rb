require 'rails_helper'

RSpec.describe do

  describe 'UserRegistration' do
    it 'allows a user to register' do
      visit "/users/sign_up"
      fill_in 'First name', :with => 'New'
      fill_in 'Last name', :with => 'User'
      fill_in 'Email', :with => 'newuser@example.com'
      fill_in 'Password', :with => 'userpassword'
      fill_in 'Password confirmation', :with => 'userpassword'
      click_button 'Sign up'
      page.has_content?('Welcome,')
    end
  end

end

