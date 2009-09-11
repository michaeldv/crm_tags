class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings, :force => true do |t|
      t.references  :tag
      t.references  :tagger, :polymorphic => true
      t.references  :taggable, :polymorphic => true
      t.string      :context, :default => ""
      t.timestamps
    end

    add_index :taggings, :tag_id
    add_index :taggings, [ :taggable_id, :taggable_type, :context ]
  end

  def self.down
    drop_table :taggings
  end
end

