class CreatePersonGames < ActiveRecord::Migration[5.0]
  def change
    create_table :person_games do |t|
      t.references :person, foreign_key: true
      t.integer :points
      t.boolean :win

      t.timestamps
    end
  end
end
