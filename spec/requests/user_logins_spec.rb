require 'spec_helper'

describe "UserLogins" do
  let(:registered_user) { FactoryGirl.create(:user) }

  describe "when sign in" do
    before do
      visit new_user_session_path
    end

    describe "with incorrect email and/or password" do
      it "shows errors validations" do
        fill_in "Email", :with => registered_user.email
        fill_in "Password", :with => "123"
        click_on "Sign in"

        page.should have_content("Invalid email or password")
      end
    end

    describe "with correct email and password" do
      it "logs the user in" do
        fill_in "Email", :with => registered_user.email
        fill_in "Password", :with => registered_user.password
        click_on "Sign in"

        page.should have_content("Hello, #{registered_user.email}")
      end
    end
  end

  context "when sign out" do
    before do
      login_as(registered_user, :scope => :user)
    end

    it "logs the user out" do
      visit users_path
      click_on "Sign out"

      page.should have_content("Signed out successfully")
      page.should_not have_content("Hello, #{registered_user.email}")
    end
  end
end
