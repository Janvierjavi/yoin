class AddUserRefToSenryus < ActiveRecord::Migration[5.2]
  def change
    add_reference :senryus, :user, foreign_key: true
  end
end
