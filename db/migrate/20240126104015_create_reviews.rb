class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|

      t.integer :user_id, null: false
      t.integer :post_id,  null: false
      t.text :content
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
