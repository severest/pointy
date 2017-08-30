class Person < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :person_games

  validates :name, presence: true

  def slug_candidates
    [
      :name,
      [:name, :id],
    ]
  end

  def games_played_by_game_type(game_type_id, season = nil)
    if season.nil?
      self.person_games.includes(:game).where('games.game_type_id': game_type_id).count
    else
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, 'games.created_at': season[:start]..season[:finish]).count
    end
  end

  def games_played(season = nil)
    if season.nil?
      self.person_games.count
    else
      self.person_games.where('created_at': season[:start]..season[:finish]).count
    end
  end

  def wins(game_type_id, season = nil)
    if season.nil?
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, win: true).count
    else
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, win: true, 'games.created_at': season[:start]..season[:finish]).count
    end
  end

  def win_percentage(game_type_id, season = nil)
    if season.nil?
      wins = self.person_games.includes(:game).where('games.game_type_id': game_type_id, win: true).count
      total_games = self.person_games.includes(:game).where('games.game_type_id': game_type_id).count
    else
      wins = self.person_games.includes(:game).where('games.game_type_id': game_type_id, win: true, 'games.created_at': season[:start]..season[:finish]).count
      total_games = self.person_games.includes(:game).where('games.game_type_id': game_type_id, 'games.created_at': season[:start]..season[:finish]).count
    end
    return wins.to_f / total_games
  end

  def total_wins
    self.person_games.includes(:game).where(win: true).count
  end

  def total_points_by_game_type(game_type_id, season = nil)
    if season.nil?
      self.person_games.includes(:game).where('games.game_type_id': game_type_id).sum(:points)
    else
      self.person_games.includes(:game).where('games.game_type_id': game_type_id, 'games.created_at': season[:start]..season[:finish]).sum(:points)
    end
  end

  def total_points(season = nil)
    if season.nil?
      self.person_games.sum(:points)
    else
      self.person_games.includes(:game).where('games.created_at': season[:start]..season[:finish]).sum(:points)
    end
  end

  def points_per_game(game_type_id, season = nil)
    self.total_points_by_game_type(game_type_id, season).to_f / self.games_played_by_game_type(game_type_id, season).to_f
  end
end
