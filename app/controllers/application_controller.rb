class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def get_season
    @current_season = Season.get_current()
    if params[:season].present?
      if params[:season] == 'all'
        @season = nil
      else
        begin
          @season = Season.get_current(Time.parse(params[:season]))
        rescue
          @season = nil
        end
      end
    else
      @season = @current_season
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def require_login
    unless current_user != nil
      return redirect_to login_url
    end

    unless current_user.email =~ Rails.configuration.domain_whitelist
      return redirect_to not_allowed_url
    end
  end

end
