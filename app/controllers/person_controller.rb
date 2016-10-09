class PersonController < ApplicationController
  def index
    @leaderboards = []
    GameType.all().each do |t|
      people = Person.includes(person_games: [game: [:game_type]]).where('game_types.name': t.name)
      @leaderboards.push({
          :game => t.name,
          :people => people
      })
    end
    @games = Game.all().order(created_at: :desc).limit(50)
  end
end
