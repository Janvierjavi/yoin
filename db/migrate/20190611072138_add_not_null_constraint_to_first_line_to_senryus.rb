class AddNotNullConstraintToFirstLineToSenryus < ActiveRecord::Migration[5.2]
  def change
    change_column :senryus, :first_line, :string, null: false
  end
end
