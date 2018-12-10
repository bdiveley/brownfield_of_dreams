class FriendshipsController < ApplicationController

  def create
    binding.pry
    friend = User.find_by(github_id: params[:friend_id])
    if friend === nil
      flash[:error] = "Cannot add friends with unlinked GitHub accounts"
      redirect_to dashboard_path
    else
      friendship = current_user.friendships.create(:friend_id => friend.id)
      redirect_to dashboard_path
    end
  end

end
