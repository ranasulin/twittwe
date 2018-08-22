class CreateUserConnectionsTable < ActiveRecord::Migration
  def change
    create_table "user_connections", force: true, id: false do |t|
      t.integer 'follower_id'
      t.integer 'followee_id'
    end
  end
end
