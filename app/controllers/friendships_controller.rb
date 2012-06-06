
class FriendshipsController < ApplicationController
  respond_to :html, :js

  def create
    friend = User.find(params[:friend_id])
    current_user.be_friends_with(friend)

    redirect_to user_path(friend)
  end

  def update
    @friendship = Friendship.find(params[:id])
    if params[:be_friends]
      @friendship.accept!
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
  end
end
