require 'rails_helper'

RSpec.describe '/register', type: :feature do
  before do
    @steve = User.create!(name: "steve", email: "steve@steve.com")
    visit '/register'
  end
  describe "When a user visits the registration page" do
    it 'should have a form to register' do
      expect(page).to have_content("Register User")
    end

    it "should fill in form, click submit, and be redirected to dashboard ('/users/:id'), where id was the user.id just created" do
      fill_in :name, with: "Larry"
      fill_in :email, with: "Larry@yahoo.com"

      click_button "Submit"
      expect(current_path).to eq("/users/#{User.last.id}")
      expect(page).to have_content("User was successfully created")
    end
    
    describe 'sad path for user registration' do
      it "should not create a user if email is not filled in" do
        fill_in :name, with: "Katie"
        click_button "Submit"

        expect(current_path).to eq("/register")
      end

      it "should not create a user if email is not unique " do
        fill_in :name, with: "Katie"
        fill_in :email, with: "steve@steve.com"
        click_button "Submit"

        expect(current_path).to eq("/register")
        expect(page).to have_content("Email already exists for a user")
      end
    end
  end
end