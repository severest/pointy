class Person < ApplicationRecord
  has_many :person_games

  validates :name, presence: true

  def games_played
    self.person_games.count
  end

  def wins
    self.person_games.where(win: true).count
  end

  def total_points
    self.person_games.sum(:points)
  end

  def points_per_game
    self.total_points.to_f / self.games_played.to_f
  end
end
