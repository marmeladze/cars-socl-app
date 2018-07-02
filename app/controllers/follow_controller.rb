class FollowController < ApplicationController

  def user
    current_user.follow_user(get_user)
    flash[:success] = "You are now following #{get_user.display_name}."
    redirect_back(fallback_location: root_path)
  end

  def unfollow_user
    current_user.unfollow_user(get_user)
    flash[:success] = "You are now unfollowing #{get_user.display_name}."
    redirect_back(fallback_location: root_path)
  end

  def motor
    current_user.follow_motor(get_motor)
    flash[:success] = "You are now following #{get_motor.name}."
    redirect_back(fallback_location: root_path)
  end

  def unfollow_motor
    current_user.unfollow_motor(get_motor)
    flash[:success] = "You are now unfollowing #{get_motor.name}."
    redirect_back(fallback_location: root_path)
  end

  def company
    current_user.follow_company(get_company)
    flash[:success] = "You are now following #{get_company.name}."
    redirect_back(fallback_location: root_path)
  end


  def unfollow_company
    current_user.unfollow_company(get_company)
    flash[:success] = "You are now unfollowing #{get_company.name}."
    redirect_back(fallback_location: root_path)
  end

  private

  def get_user
    @user ||= User.find(params.require(:id))
  end

  def get_motor
    @motor ||= Motor.find(params.require(:id))
  end

  def get_company
    @company ||= Company.find(params.require(:id))
  end
end
