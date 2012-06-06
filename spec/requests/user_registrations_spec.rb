require 'spec_helper'

describe "UserRegistrations" do
  context "when signing up" do
    before do
      visit new_user_registration_path
    end

    context "with missing infos" do
      it "shows validation errors" do
        fill_in 'Email', :with => "wrong@format"
        fill_in 'Password', :with => "123"
        fill_in 'Hometown', :with => "Recife"
        click_on 'Sign up'

        page.should have_content('Email is invalid')
        page.should have_content('Password is too short')
      end
    end

    context "with all infos" do
      it "creates the user" do
        email = "cool@email.com"
        fill_in "Email", :with => email
        fill_in "Password", :with => "123456"
        fill_in "Password confirmation", :with => "123456"
        click_on "Sign up"

        page.should have_content('Welcome!')
        page.should have_content('Listing users')
        page.should have_content(email)
      end
    end
  end
end
