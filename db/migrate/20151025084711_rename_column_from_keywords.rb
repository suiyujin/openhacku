class RenameColumnFromKeywords < ActiveRecord::Migration
  def change
    rename_column :keywords, :keyword, :name
  end
end
