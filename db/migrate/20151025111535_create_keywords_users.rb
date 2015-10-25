class CreateKeywordsUsers < ActiveRecord::Migration
  def change
    create_table :keywords_users do |t|
      t.references :keyword, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false
    end
  end
end
