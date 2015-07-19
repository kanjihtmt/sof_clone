class RenameQuestionCountToTaggingCount < ActiveRecord::Migration
  def change
    rename_column :tags, :questions_count, :taggings_count
  end
end
