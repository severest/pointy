class PersonController < ApplicationController
  def index
    @leaderboards = []
    GameType.all().each do |game_type|
      people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': game_type.name)
      sorted_people = people.sort_by{ |person| [person.wins(game_type.id), person.points_per_game(game_type.id)] }
      @leaderboards.push({
          :game => game_type.name,
          :game_type_id => game_type.id,
          :people => sorted_people.reverse
      })
    end
    @games = Game.all().order(created_at: :desc).limit(50)
  end
end
