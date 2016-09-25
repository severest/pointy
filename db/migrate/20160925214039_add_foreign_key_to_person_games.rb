class AddForeignKeyToPersonGames < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :person_games, :people
    add_foreign_key :person_games, :people, on_delete: :cascade
  end
end
