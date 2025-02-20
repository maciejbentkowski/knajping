class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content

      t.references :user, foreign_key: true
      t.references :venue, null: false, foreign_key: true
      t.timestamps
    end
  end
end
