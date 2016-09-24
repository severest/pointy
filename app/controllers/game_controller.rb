class GameController < ApplicationController
  def new
  end

  def create
    game = game_params
    @person = Person.find_or_create_by(name: game[:name])
    @gameModel = @person.person_games.create!(points: game[:points], win: game[:winner])
    redirect_to root_url
  end

  private
    def game_params
      params.require(:game).permit(:name, :points, :winner)
    end
end
