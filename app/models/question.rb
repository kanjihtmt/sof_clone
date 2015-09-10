class Question < ActiveRecord::Base
  include Votable

  # コード量は増えてしまうのですが同じ文字列を複数の場所で使う場合には
  # HOT_RANGE = 'hot'.freeze
  # WEEK_RANGE = 'week'.freeze
  # MONTH_RANGE = 'month'.freeze
  # と定義して下のscopeのcase部分で when HOT_RANGE みたいにして、typoした場合にはエラーが発生するようにします
  # questions/index.html.haml の所でも 'hot' の所を Question::HOT_RANGE みたいにして、typoを防ぎます
  # scope :sort の所では TIME_RANGES = [HOT_RANGE, WEEK_RANGE, MONTH_RANGE].freeze
  # を定義しておいて when TIME_RANGES.include?(type) と書きます。(少し見た目がゴツくなりますが。。。)

  scope :sort, ->(type) do
    case (type)
      when 'hot', 'week', 'month'
        order(answers_count: :desc, updated_at: :desc)
      else
        order(created_at: :desc, updated_at: :desc)
    end
  end

  scope :interval, -> (type) do
    case (type)
      when 'hot'
        from, to = (Time.now - 2.day).at_beginning_of_day, Time.now
        where(updated_at: from..to)
      when 'week'
        from, to = (Time.now - 6.day).at_beginning_of_day, Time.now
        where(updated_at: from..to)
      when 'month'
        from, to = Time.now.at_beginning_of_month, Time.now
        where(updated_at: from..to)
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

  def self.unanswered(page)
    self.page(page).per(PAGE_MAX)
      .includes(:questioner, :tags)
      .where('id NOT IN (SELECT DISTINCT(question_id) FROM answers)')
      .order(answers_count: :desc, created_at: :desc)
  end
end
