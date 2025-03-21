class RemoveTitleFromReview < ActiveRecord::Migration[8.0]
  def change
    remove_column :reviews, :title, :string
  end
end
