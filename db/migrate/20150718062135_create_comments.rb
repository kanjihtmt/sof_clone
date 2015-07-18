class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :commentable, index: true, polymorphic: true
      t.integer :commenter_id

      t.timestamps null: false
    end

    add_index :comments, :commenter_id
  end
end
