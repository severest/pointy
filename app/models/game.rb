class Game < ApplicationRecord
  has_many :person_games
  belongs_to :game_type

  def winner
    person_game = self.person_games.where(win: true).first()
    person_game.person.name
  end

  def leaderboard
    self.person_games.order(points: :desc)
  end
end
