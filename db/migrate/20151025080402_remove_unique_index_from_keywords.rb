class RemoveUniqueIndexFromKeywords < ActiveRecord::Migration
  def change
    remove_index :keywords, :keyword
    add_index :keywords, :keyword
  end
end
