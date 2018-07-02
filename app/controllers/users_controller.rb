class UsersController < ApplicationController
  before_action :set_entity, only: [:news_feed, :profile]
  before_action :get_user, only: [:profile]

  def news_feed
    @user = current_user
  end

  def profile
  end

  def upload_pic
    if current_user.update_attributes(pic_attrs)
      flash[:success] = "Updated pic successfully"
    else
      flash[:error] = "Failed to update pic"
    end
    redirect_to user_profile_path
  end

  def search
    users = User.search(params[:term], current_user)
    render json: users.to_json, status: 200
  end

  def show
    @user = User.find(params[:id])
    set_current_entity(@user)
    render 'profile'
  end

  private
  def set_entity
    set_current_entity(current_user)
  end

  def pic_attrs
    params.require(:user).permit(
      profile_attributes: [:avatar, :cover_pic]
    )
  end

  def get_user
    @user ||= if params[:id].present?
      User.find(params[:id])
    else
      current_user
    end
  end
end
