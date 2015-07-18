class AddQuestionerIdColumnToUsers < ActiveRecord::Migration
  def change
    #add_reference :questions, :questioner, index: true, foreign_key: true
    add_column :questions, :questioner_id, :integer
    add_index :questions, :questioner_id
  end
end
