class RenameContentColumnToSenryus < ActiveRecord::Migration[5.2]
  def change
    rename_column :senryus, :content, :first_line
  end
end
