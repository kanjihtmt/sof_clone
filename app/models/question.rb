class Question < ActiveRecord::Base
  include VoteCountable

  scope :active, -> { order(updated_at: :desc, created_at: :desc) }
  scope :newest, -> { order(created_at: :desc)}
  scope :hot, -> { where(updated_at: (Time.now - 2.day).at_beginning_of_day .. Time.now).order(answers_count: :desc) }
  scope :week, -> { where(updated_at: (Time.now - 6.day).at_beginning_of_day .. Time.now).order(answers_count: :desc) }
  scope :month, -> { where(updated_at: (Time.now - 1.month).at_beginning_of_day .. Time.now).order(answers_count: :desc) }

  belongs_to :questioner, class_name: 'User'
  has_many :answers
  belongs_to :best_answer, class_name: 'Answer'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.find_by_tab(tab)
    case tab
      when 'active'
        @questions = self.active
      when 'hot'
        @questions = self.hot
      when 'week'
        @questions = self.week
      when 'month'
        @questions = self.month
      else
        @questions = self.newest
    end
  end
end
