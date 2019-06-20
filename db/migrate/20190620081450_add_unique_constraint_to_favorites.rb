class AddUniqueConstraintToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_index :favorites, [:user_id, :senryu_id], unique: true
  end
end
