class AddDismissToUserConnections < ActiveRecord::Migration
  def change
    add_column :user_connections, :dismiss, :boolean, default: false
  end
end
