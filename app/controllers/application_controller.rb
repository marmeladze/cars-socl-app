class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found

  helper_method :current_entity

  def after_sign_in_path_for(resource_or_scope)
    set_current_entity(current_user)
    news_feed_path
  end

  private
  def set_current_entity(object)
    session[:current_entity_class] = object.class.to_s
    session[:current_entity_id] = object.id.to_s
    @current_entity = object
  end

  def current_entity
    @current_entity ||= get_current_entity
  end

  def get_current_entity
    klass = session[:current_entity_class].constantize
    klass.where(_id: session[:current_entity_id]).first
  end

  def render_with_error(message, status_code)
    return unless request.xhr?
    render status: status_code,
      partial: 'shared/error_content',
      locals: { message: message } and return
  end

  def record_not_found(exception)
    render json: { error: exception.message }.to_json, status: 404
  end
end
