class RemoveIndexFromFollowedIdToRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_index :relationships, name: "index_relationships_on_followed_id"
  end
end
