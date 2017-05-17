class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :hotel, foreign_key: true
      t.integer :star_rating_user
      t.text :description

      t.timestamps
    end

     add_index :comments, :star_rating_user
     add_index :comments, [:user_id, :hotel_id], unique: true
  end
end
