class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.string :title
      t.float :star_rating
      t.integer :star_rating_owner
      t.boolean :is_breakfest
      t.text :room_description
      t.string :photo
      t.string :address
      t.float :price_of_room, default: 0.0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
