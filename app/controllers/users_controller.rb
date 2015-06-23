class UsersController < ApplicationController

  def index
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end

  def show
    @user = User.find(params[:id])
    @moos = @user.moos(params[:moo_id])
  end

  def follow
    @user = User.find(params[:id])

    if current_user
      if current_user == @user
        flash[:error] = "You cannot follow yourself."
      else
        current_user.follow(@user)
        # RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
        redirect_to root_path flash[:notice] = "You are now following #{@user.name}."
      end
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.name}.".html_safe
    end
  end

  def unfollow
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      flash[:notice] = "You are no longer following #{@user}."
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user}.".html_safe
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def user_params
    params.require(:user).permit(:user_id, :name, :avatar)
  end
end

