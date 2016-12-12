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

end
