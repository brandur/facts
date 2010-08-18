class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.references :category
      t.string :name, :null => false
      t.string :slug

      t.timestamps
    end

    add_index :categories, :slug
  end

  def self.down
    drop_table :categories
  end
end
