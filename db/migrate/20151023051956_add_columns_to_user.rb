class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_img_url, :string, null: false, default: 'image/dummy_profile.jpg'
    add_column :users, :cover_img_url, :string, null: false, default: 'image/dummy_cover.jpg'
  end
end
