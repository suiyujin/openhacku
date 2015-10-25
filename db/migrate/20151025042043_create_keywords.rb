class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :keyword, null: false
    end
    add_index :keywords, :keyword, unique: true
  end
end
