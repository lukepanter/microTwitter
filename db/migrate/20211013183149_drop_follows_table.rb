class DropFollowsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :follows
  end

  def down
  end
end
