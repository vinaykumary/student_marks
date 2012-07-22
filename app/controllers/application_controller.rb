class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  protected

    def authorize
      unless current_user
        session[:original_target]=request.url
        redirect_to login_url, :notice=>"Please Login"
      end

    end

  helper_method :current_user
end
