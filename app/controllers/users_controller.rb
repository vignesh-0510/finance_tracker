class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present?
      # @friends = User.where(first_name: params[:friend])
      # @friends = User.where(last_name: params[:friend]) if @friends.nil?
      # @friends = User.where(email: params[:friend]) if @friends.nil?

      @friends_search = User.search(params[:friend])
      @friends_search = current_user.except_current_user(@friends_search)
      if !@friends_search.nil?
        respond_to do |format|
          format.js { render partial: 'users/friend_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid user"
          format.js { render partial: 'users/friend_result'}
        end
      end
    else
      respond_to do |format|
          flash.now[:alert] = "Please enter a friend to search"
          format.js { render partial: 'users/friend_result'}
        end
    end

    # render json: params[:friend]
  end
end
