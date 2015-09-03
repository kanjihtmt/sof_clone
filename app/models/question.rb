class Question < ActiveRecord::Base
  include Votable

  scope :sort, ->(sort_type) do
    case (sort_type)
      when 'active'
        order(created_at: :desc, updated_at: :desc)
      when 'newest'
        order(created_at: :desc)
      when 'hot'
        from, to = (Time.now - 2.day).at_beginning_of_day, Time.now
        where(updated_at: from..to).order(answers_count: :desc)
      when 'week'
        from, to = (Time.now - 6.day).at_beginning_of_day, Time.now
        where(updated_at: from..to).order(answers_count: :desc, created_at: :desc)
      when 'month'
        from, to = Time.now.at_beginning_of_month, Time.now
        where(updated_at: from..to).order(answers_count: :desc, created_at: :desc)
      when 'unanswered'
        where('id NOT IN (SELECT DISTINCT(question_id) FROM answers)')
          .order(answers_count: :desc, created_at: :desc)
    end
  end

  attr_accessor :tag_list

  belongs_to :questioner, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer'
  has_many :answers, -> { includes :comments, :answerer }
  has_many :comments, -> { includes :commenter }, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { minimum: 8 }
  validates :body, presence: true, length: { minimum: 20 }
  validates :questioner_id, presence: true
  validates :tag_list, presence: { message: '少なくとも1つ以上のタグを入力してください。' }

  before_save do
    tags = []
    self.tag_list.split(',').each do |tag|
      tags << Tag.find_or_create_by(title: tag)
    end
    self.tags = tags
  end

  after_find do
    self.tag_list = self.tags.map(&:title).join(",") unless self.tag_list
  end

  is_impressionable
end
