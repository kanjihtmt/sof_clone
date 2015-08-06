class Tag < ActiveRecord::Base
  scope :popular, -> { order(taggings_count: :desc) }
  scope :byname, -> { order(title: :asc) }
  scope :newest, -> { order(created_at: :desc) }
  scope :search, ->(keyword) { where('title like ?', '%' + keyword + '%') }

  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  validates :title, presence: true

  def self.find_by_keyword_and_tab(keyword, tab)
    case tab
      when 'name'
        keyword.nil? ? self.byname : self.search(keyword).byname
      when 'new'
        keyword.nil? ? self.newest : self.search(keyword).newest
      else
        keyword.nil? ? self.popular : self.search(keyword).popular
    end
  end
end
