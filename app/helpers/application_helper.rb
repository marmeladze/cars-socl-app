module ApplicationHelper

  def body_klass
    'login-page' if controller_name.eql?('sessions')
  end

  def cover_pic_url(entity)
    if entity.cover_pic.present?
      entity.cover_pic.url
    else
      '../assets/avatars/user-2-avatar.jpg'
    end
  end
end
