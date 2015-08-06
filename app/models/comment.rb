class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User'

  validates :body, :commentable_id, :commentable_type, :commenter_id, presence: true
end
