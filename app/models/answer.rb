class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: 'User'
  belongs_to :question
  has_many :votes, as: votable, dependent: :destroy
  has_many :comments, as: commentable, dependent: :destroy
end
