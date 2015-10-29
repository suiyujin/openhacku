class RenameCoverImgUrlToHeaderImgUrl < ActiveRecord::Migration
  def change
    remove_column :users, :cover_img_url
    add_column :users, :header_img_url, :string, null: false, default: 'image/dummy_header.jpg'
  end
end
