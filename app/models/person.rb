class Person < ApplicationRecord
  has_many :person_games

  validates :name, presence: true

  def games_played(game_type_id)
    self.person_games.includes(:game).where('games.game_type_id': game_type_id).count
  end

  def wins(game_type_id)
    self.person_games.includes(:game).where('games.game_type_id': game_type_id, win: true).count
  end

  def total_points(game_type_id)
    self.person_games.includes(:game).where('games.game_type_id': game_type_id).sum(:points)
  end

  def points_per_game(game_type_id)
    self.total_points(game_type_id).to_f / self.games_played(game_type_id).to_f
  end
end
