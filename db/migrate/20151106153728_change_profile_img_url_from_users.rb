class ChangeProfileImgUrlFromUsers < ActiveRecord::Migration
  def change
    change_column :users, :profile_img_url, :string, null: false, default: 'http://210.140.71.3/image/profile/default.png'
  end
end
