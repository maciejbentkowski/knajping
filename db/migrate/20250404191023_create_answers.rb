class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.belongs_to :question, index: true, foreign_key: true, null: false
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
    add_column :questions, :count_of_answers, :integer, default: 0, null: false
  end
end
