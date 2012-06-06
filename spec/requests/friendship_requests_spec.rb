require 'spec_helper'

describe "FriendshipRequests" do
  let(:user) { FactoryGirl.create(:user) }
  let(:friend) { FactoryGirl.create(:user) }

  describe "when resquesting someone as a friend" do
    before do
      login_as(user, :scope => :user)
    end

    it "creates a pending friendship" do
      visit user_path(friend)
      click_link 'Add as a friend'

      page.should have_content("Waiting for #{friend.email} approval")
    end
  end

  describe "when accepting a friend request through AJAX", :js => true do
    before do
      friend.be_friends_with(user)
      login_as(user, :scope => :user)
    end

    let(:friendship) { user.friendship_for(friend) }

    it "make them both just good friends" do
      visit root_path
      within "li#friendship-#{friendship.id}" do
        click_link "Accept"
        page.should have_content "Convite aceito"

        find(".user-profile").click
      end

      page.should have_content("You and #{friend} are friends")
    end
  end

  describe "when denying a friend request through AJAX", :js => true do
    before do
      friend.be_friends_with(user)
      login_as(user, :scope => :user)
    end

    let(:friendship) { user.friendship_for(friend) }

    it "make them both just good friends" do
      visit root_path
      within "li#friendship-#{friendship.id}" do
        click_link "Deny"
        page.should have_content "Convite negado"

        find(".user-profile").click
      end

      page.should have_content("Add as a friend")
    end
  end
end
