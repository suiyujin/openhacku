class AddColumnToKeywords < ActiveRecord::Migration
  def change
    add_reference :keywords, :category, index: true, foreign_key: true, null: false
  end
end
