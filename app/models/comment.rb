class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User'

  validates_presence_of :body, :commentable_id, :commentable_type, :commenter_id
end
