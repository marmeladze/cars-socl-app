class SettingsController < ApplicationController

  def account
    if request.post? && current_user.update_attributes(account_attrs)
      flash.now[:success] = 'Account Settings updated successfully'
    end
  end

  def security
    @user = current_user
    resp = if request.post? && params[:user] && params[:user][:password].present?
      if @user.update_with_password(passwords_attrs)
        sign_in(@user, bypass: true)
        true
      end
    elsif request.post?
      @user.update_attributes(legacy_contacts_attrs)
    end
    if request.post? && resp
      flash.now[:success] = 'Security Settings updated successfully'
    end
  end

  def privacy
    if request.post?
      current_user.privacy_preference.update_attributes(privacy_attrs)
      flash.now[:success] = 'Privacy Preferences updated successfully'
    end
    @privacy = current_user.privacy_preference
  end

  def notifications
    if request.post?
      current_user.email_preference.update_attributes(email_preference_attrs)
      current_user.app_preference.update_attributes(app_preference_attrs)
      flash.now[:success] = 'Notification Preferences updated successfully'
    end
    @email = current_user.email_preference
    @in_app = current_user.app_preference
  end

  private
  def account_attrs
    params.require(:user).permit(:name, :username, :known_by, 
      :country, :country_code, :state, :state_code, :city)
  end

  def passwords_attrs
    params.require(:user).permit(:password, :current_password, :password_confirmation,
      :legacy_contact_name, :legacy_contact_email)
  end

  def legacy_contacts_attrs
    params.require(:user).permit(:legacy_contact_name, :legacy_contact_email)
  end

  def app_preference_attrs
    params.require(:app).permit(:someone_tags_me, :new_comment,
      :new_group_activity, :follow_request, :new_like, :rebrag)
  end

  def email_preference_attrs
    params.require(:email).permit(:someone_tags_me, :new_comment, :new_group_activity)
  end

  def privacy_attrs
    params.require(:privacy).permit(:posts, :timeline, :comments, :follow)
  end
end
