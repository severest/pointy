class AddGameRefToPersonGames < ActiveRecord::Migration[5.0]
  def change
    add_reference :person_games, :game, foreign_key: true
  end
end
