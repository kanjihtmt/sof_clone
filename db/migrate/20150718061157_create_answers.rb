class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, index: true, foreign_key: true
      t.integer :answerer_id

      t.timestamps null: false
    end

    add_index :answers, :answerer_id
  end
end
