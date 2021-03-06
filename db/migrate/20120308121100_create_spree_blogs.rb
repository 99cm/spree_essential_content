class CreateSpreeBlogs < ActiveRecord::Migration[5.2]
  def self.up
    create_table :spree_blogs do |t|
      t.string     :name, nil: false
      t.string     :permalink, nil: false, length: 40
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :spree_blogs
  end
end
