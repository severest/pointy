class AddGameTypeToGame < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :game_type, foreign_key: true
  end
end
