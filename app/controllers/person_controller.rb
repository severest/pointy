class PersonController < ApplicationController
  before_action :get_season, only: [:show]

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

  def list
    @people = Person.where("name LIKE ?", "%#{params[:query]}%")
    render json: { suggestions: @people.pluck(:name).to_a }
  end

  def show
    @seasons = []
    @seasons.push(@current_season)
    @seasons.unshift(Season.get_current(@current_season[:start].prev_quarter))
    @seasons.unshift(Season.get_current(@seasons[0][:start].prev_quarter))
    @seasons.push(Season.get_current(@current_season[:start].next_quarter))
    @seasons.push(Season.get_current(@seasons[3][:start].next_quarter))
    
    @person = Person.friendly.find(params[:id])
    @game_types = GameType.all()
  end
end
