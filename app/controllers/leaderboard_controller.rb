class LeaderboardController < ApplicationController
  before_action :get_season

  def index
    @leaderboards = []
    GameType.all().each do |game_type|
      if @season.present?
        people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': game_type.name, 'games.created_at': @season[:start]..@season[:finish])
      else
        people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': game_type.name)
      end

      if game_type.reverse_points
        sorted_people = people.sort_by{ |person| [person.wins(game_type.id, @season), person.points_per_game(game_type.id, @season) * (-1)] }
      else
        sorted_people = people.sort_by{ |person| [person.wins(game_type.id, @season), person.points_per_game(game_type.id, @season)] }
      end
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

end
