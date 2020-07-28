class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      redirect_to my_friends_path, notice: "Following User!"
    else
      redirect_to my_friends_path, alert: "Something went wrong!"
    end
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    redirect_to my_friends_path, notice: "Stopped Following"
  end
end
