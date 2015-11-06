class AddReviewAveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :review_ave, :float
  end
end
