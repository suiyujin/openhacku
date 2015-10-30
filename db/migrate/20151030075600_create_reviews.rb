class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :score, null: false
      t.string :comment
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.references :ticket, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_foreign_key :reviews, :users, column: :from_user_id
    add_foreign_key :reviews, :users, column: :to_user_id
  end
end
