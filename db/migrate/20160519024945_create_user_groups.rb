class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.string :name
      t.string :hashtag

      t.timestamps null: false
    end
  end
end
