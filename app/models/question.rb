class Question < ActiveRecord::Base
  include VoteCountable

  scope :active, -> { order(updated_at: :desc, created_at: :desc) }

  belongs_to :questioner, class_name: 'User'
  has_many :answers
  belongs_to :best_answer, class_name: 'Answer'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.find_by_tab(tab)
    case tab
      when :active
        @questions = self.active
      when :hot
        @questions = self.all
      when :week
        @questions = self.all
      when :month
        @questions = self.all
      else
        @questions = self.all
    end
  end
end
