class AddLowToHighToGameTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :game_types, :reverse_points, :boolean, default: false
  end
end
