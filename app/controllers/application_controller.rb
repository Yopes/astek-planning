class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include HomeHelper

  def redirect_back
    redirect_to (request.referer.present? ? :back : :root)
  end

  def redirect_not_connected
    redirect_to :root if !signed_in?
  end

  def redirect_not_admin
    redirect_to :root if !admin?
  end

end
