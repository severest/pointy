class StatsController < ApplicationController

  def fact
    talking_point_type = rand(3)
    time_range_type = rand(3)

    if talking_point_type == 1
      # talk about game_types
      game_type = GameType.get_random
      if time_range_type == 1
        # all-time
        count = game_type.games.count()
        message = "#{ActionController::Base.helpers.pluralize(count, 'game')} of #{game_type.name} have been played all time"
      elsif time_range_type == 2
        # this season
        count = game_type.games.where('games.created_at': Time.now.utc.beginning_of_quarter..Time.now.utc.end_of_quarter).count()
        message = "#{ActionController::Base.helpers.pluralize(count, 'game')} of #{game_type.name} have been played this season"
      else
        # this week
        count = game_type.games.where('games.created_at': Time.now.utc.beginning_of_week..Time.now.utc.end_of_week).count()
        message = "#{ActionController::Base.helpers.pluralize(count, 'game')} of #{game_type.name} have been played this week"
      end
    elsif talking_point_type == 2
      count = PersonGame.sum(:points)
      message = "#{ActionController::Base.helpers.pluralize(count, 'point')} have been scored all time"
    else
      # talk about people
      person = Person.get_random
      if time_range_type == 1
        # all time
        count = person.person_games.count()
        message = "#{person.name} has played #{ActionController::Base.helpers.pluralize(count, 'game')} all time"
      elsif time_range_type == 2
        # this season
        count = person.person_games.where('person_games.created_at': Time.now.utc.beginning_of_quarter..Time.now.utc.end_of_quarter).count()
        message = "#{person.name} has played #{ActionController::Base.helpers.pluralize(count, 'game')} this season"
      else
        # this week
        count = person.person_games.where('person_games.created_at': Time.now.utc.beginning_of_week..Time.now.utc.end_of_week).count()
        message = "#{person.name} has played #{ActionController::Base.helpers.pluralize(count, 'game')} this week"
      end
    end
    render json: { fact: message }
  end

end
