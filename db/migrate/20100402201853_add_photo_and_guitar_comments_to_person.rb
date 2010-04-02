class AddPhotoAndGuitarCommentsToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :photo_comment_notifications, :boolean, :default => true
    add_column :people, :guitar_comment_notifications, :boolean, :default => true
    add_column :people, :photo_comments_count, :integer, :default => 0, :null => false
    add_column :people, :guitar_comments_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :people, :guitar_comments_count
    remove_column :people, :photo_comments_count
    remove_column :people, :guitar_comment_notifications
    remove_column :people, :photo_comment_notifications
  end
end
