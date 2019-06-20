class AddIndexToColumnsToSenryus < ActiveRecord::Migration[5.2]
  def change
    add_index :senryus, :first_line
    add_index :senryus, :second_line
    add_index :senryus, :third_line
  end
end
