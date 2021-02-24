class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @votes = @user.votes
  end
end
