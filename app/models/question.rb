class Question < ActiveRecord::Base
  include VoteCountable

  scope :active, -> { order(updated_at: :desc, created_at: :desc) }
  scope :newest, -> { order(created_at: :desc)}
  scope :hot, -> { where(updated_at: (Time.now - 2.day).at_beginning_of_day .. Time.now).order(answers_count: :desc) }
  scope :week, -> { where(updated_at: (Time.now - 6.day).at_beginning_of_day .. Time.now).order(answers_count: :desc) }
  scope :month, -> { where(updated_at: (Time.now - 1.month).at_beginning_of_day .. Time.now).order(answers_count: :desc) }

  attr_accessor :tag_list

  belongs_to :questioner, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer'
  has_many :answers
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 8 }
  validates :body, presence: true, length: { minimum: 20 }
  validates :tag_list, presence: { message: '少なくとも1つのタグを入力して下さい。人気のあるタグのリストを参照してください。' }

  before_save do
    self.tag_list.split(',').each do |tag|
      self.tags << Tag.find_or_initialize_by(title: tag)
    end
  end

  after_find do
     self.tag_list = self.tags.map(&:title).join(",") unless self.tag_list
  end

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

  #def show_tags
  #  self.tags.map(&:title).join(",")
  #end
end
