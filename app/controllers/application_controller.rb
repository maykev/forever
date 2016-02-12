class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :allow_godaddy_iframe

  private

  def allow_godaddy_iframe
    response.headers['X-Frame-Options'] = 'ALLOW-FROM http://amyandkevinswedding.com'
  end
end
