class AddBlockToFriendships < ActiveRecord::Migration[5.0]
  def change
    add_column :friendships, :block, :integer
  end
end
