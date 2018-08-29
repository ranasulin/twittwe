class AddIdToUserConnections < ActiveRecord::Migration
  def change
    add_column :user_connections, :id, :integer
  end
end
