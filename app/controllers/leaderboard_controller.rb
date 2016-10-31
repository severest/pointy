class LeaderboardController < ApplicationController

  def index
    @season = get_season

    @leaderboards = []
    GameType.all().each do |game_type|
      if @season.present?
        people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': game_type.name, 'games.created_at': @season[:start]..@season[:finish])
      else
        people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': game_type.name)
      end
      sorted_people = people.sort_by{ |person| [person.wins(game_type.id, @season), person.points_per_game(game_type.id, @season)] }
      @leaderboards.push({
          :game => game_type.name,
          :game_type_id => game_type.id,
          :people => sorted_people.reverse
      })
    end

    if @season.present?
      @games = Game.where(created_at: @season[:start]..@season[:finish]).order(created_at: :desc).limit(50)
    else
      @games = Game.all().order(created_at: :desc).limit(50)
    end
  end

  private

  def get_season
    if params[:season].present?
      if params[:season] == 'all'
        season = nil
      else
        begin
          season = Season.get_current(Time.parse(params[:season]))
        rescue
          season = nil
        end
      end
    else
      season = Season.get_current()
    end
    season
  end

end
