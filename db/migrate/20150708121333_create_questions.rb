class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.integer :best_answer_id, index: true

      t.timestamps null: false
    end
  end
end
