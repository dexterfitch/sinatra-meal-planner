class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :title
      t.string :href
      t.string :thumbnail
      t.integer :user_id
    end
  end
end
