class CreateMentionConnections < ActiveRecord::Migration
  def change
    create_table :table_mentions, force: true, id: false do |t|
      t.integer 'mentioned_by'
      t.integer 'mention_subject'
    end
  end
end
