class AddOwnerToVenue < ActiveRecord::Migration[8.0]
  def change
    add_reference :venues, :user, null: false, foreign_key: true
  end
end
