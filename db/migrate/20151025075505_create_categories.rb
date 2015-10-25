class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category, null: false
    end
    add_index :categories, :category, unique: true
  end
end
