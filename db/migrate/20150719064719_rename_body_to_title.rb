class RenameBodyToTitle < ActiveRecord::Migration
  def change
    rename_column :tags, :body, :title
  end
end
