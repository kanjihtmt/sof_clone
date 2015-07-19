class RenameQuestionTagToTagging < ActiveRecord::Migration
  def change
    rename_table :question_tags, :taggings
  end
end
