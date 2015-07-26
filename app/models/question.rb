class Question < ActiveRecord::Base
  include VoteCountable

  scope :sort, ->(sort_type) {
    case (sort_type)
      when 'active'
        order(updated_at: :desc, created_at: :desc)
      when 'newest'
        order(created_at: :desc)
      when 'hot'
        where(updated_at: (Time.now - 2.day).at_beginning_of_day .. Time.now).order(answers_count: :desc)
      when 'week'
        where(updated_at: (Time.now - 6.day).at_beginning_of_day .. Time.now).order(answers_count: :desc)
      when 'month'
        where(updated_at: (Time.now - 1.month).at_beginning_of_day .. Time.now).order(answers_count: :desc)
    end
  }

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

  is_impressionable

end
