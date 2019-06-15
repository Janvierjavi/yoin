class AddColumnsToSenryus < ActiveRecord::Migration[5.2]
  def change
    add_column :senryus, :second_line, :string, null: false
    add_column :senryus, :third_line, :string, null: false

  end
end
