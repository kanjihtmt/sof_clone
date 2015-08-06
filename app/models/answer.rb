class Answer < ActiveRecord::Base
  include Votable

  belongs_to :answerer, class_name: 'User'
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, -> { includes :commenter }, as: :commentable, dependent: :destroy

  validates :body, presence: true, length: { minimum: 20 }
  validates :question_id, :answerer_id, presence: true
end
