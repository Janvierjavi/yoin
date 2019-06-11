class CreateSenryus < ActiveRecord::Migration[5.2]
  def change
    create_table :senryus do |t|
      t.string :content

      t.timestamps
    end
  end
end
