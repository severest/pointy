class LeaderboardController < ApplicationController
  before_action :get_season

  def index
    @leaderboards = []
    GameType.all().each do |game_type|
      if @season.present?
        people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': game_type.name, 'games.created_at': @season[:start]..@season[:finish])
        max_person_game_query = PersonGame.select('count(person_id) as num').joins('inner join games on games.id=person_games.game_id').joins('inner join game_types on game_types.id=games.game_type_id').where('game_types.name': game_type.name, 'games.created_at': @season[:start]..@season[:finish]).group('person_id').order('num desc').limit(1).first()
        max_games_played = if max_person_game_query then max_person_game_query.num else 0 end
      else
        people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': game_type.name)
        max_person_game_query = PersonGame.select('count(person_id) as num').joins('inner join games on games.id=person_games.game_id').joins('inner join game_types on game_types.id=games.game_type_id').where('game_types.name': game_type.name).group('person_id').order('num desc').limit(1).first()
        max_games_played = if max_person_game_query then max_person_game_query.num else 0 end
      end

      if game_type.reverse_points
        sorted_people = people.sort_by{ |person| [person.win_percentage(game_type.id, max_games_played, @season), person.points_per_game(game_type.id, @season) * (-1)] }
      else
        sorted_people = people.sort_by{ |person| [person.win_percentage(game_type.id, max_games_played, @season), person.points_per_game(game_type.id, @season)] }
      end
      @leaderboards.push({
          :game => game_type.name,
          :game_type_id => game_type.id,
          :people => sorted_people.reverse,
          :max_games_played => max_games_played
      })
    end

    if @season.present?
      @games = Game.where(created_at: @season[:start]..@season[:finish]).order(created_at: :desc).limit(50)
    else
      @games = Game.all().order(created_at: :desc).limit(50)
    end
  end

end
