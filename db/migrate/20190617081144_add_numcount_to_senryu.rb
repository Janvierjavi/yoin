class AddNumcountToSenryu < ActiveRecord::Migration[5.2]
  def change
    add_column :senryus, :favorites_count, :integer
  end
end
