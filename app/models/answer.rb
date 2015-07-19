class Answer < ActiveRecord::Base
  include VoteCountable

  belongs_to :answerer, class_name: 'User'
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
