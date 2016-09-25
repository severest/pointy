class AddGameRefToPersonGames < ActiveRecord::Migration[5.0]
  def change
    add_reference :person_games, :game
    add_foreign_key :person_games, :game, on_delete: :cascade
  end
end
