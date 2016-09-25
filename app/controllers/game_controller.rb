class GameController < ApplicationController
  def new
  end

  def create
    ActiveRecord::Base.transaction do
      @game = Game.create!
      game_params[:players].each do |index, player|
        @person = Person.find_or_create_by(name: player[:name])
        @gameModel = @person.person_games.create!(
          points: player[:points],
          win: player[:winner],
          game: @game
        )
      end
    end
    redirect_to root_url
  rescue
    render json: 'uhohhh', status: :bad_request
  end

  private
    def game_params
      params.require(:game).permit(:code, players: [ :name, :points, :winner ])
    end
end
