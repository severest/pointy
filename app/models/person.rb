class Person < ApplicationRecord
  has_many :person_games

  validates :name, presence: true

  def games_played(game_type_id, season = nil)
    if season.nil?
      self.person_games.includes(:game).where('games.game_type_id': game_type_id).count
    else
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, 'games.created_at': season[:start]..season[:finish]).count
    end
  end

  def wins(game_type_id, season = nil)
    if season.nil?
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, win: true).count
    else
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, win: true, 'games.created_at': season[:start]..season[:finish]).count
    end
  end

  def total_points(game_type_id, season = nil)
    if season.nil?
      self.person_games.includes(:game).where('games.game_type_id': game_type_id).sum(:points)
    else
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, 'games.created_at': season[:start]..season[:finish]).sum(:points)
    end
  end

  def points_per_game(game_type_id, season = nil)
    self.total_points(game_type_id, season).to_f / self.games_played(game_type_id, season).to_f
  end
end
