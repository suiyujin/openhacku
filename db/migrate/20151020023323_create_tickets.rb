class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.float :time, null: false
      t.integer :price, null: false
      t.string :place, null: false
      t.boolean :bought, null: false, default: false
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :bought_user_id

      t.timestamps null: false
    end
    add_index :tickets, :bought_user_id
  end
end
