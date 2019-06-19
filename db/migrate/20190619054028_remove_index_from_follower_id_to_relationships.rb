class RemoveIndexFromFollowerIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_index :relationships, :follower_id
  end
end
