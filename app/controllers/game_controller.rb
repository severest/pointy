class GameController < ApplicationController
  def new
    @game_types = GameType.all()
  end

  def create
    ActiveRecord::Base.transaction do
      raise 'need more than one player' unless game_params[:players].to_h.size > 1

      player_names = Array.new
      @game = Game.create!(game_type_id: game_params[:game_type_id])
      game_params[:players].each do |_index, player|
        @person = Person.find_or_create_by(name: player[:name])

        raise 'duplicate player' if player_names.include?(player[:name])
        player_names.push(player[:name])

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
    params.require(:game).permit(:game_type_id, players: [ :name, :points, :winner ])
  end
end
