class Tag < ActiveRecord::Base
  scope :sort, -> (sort_type) do
    case sort_type
      when 'name'
        order(title: :asc)
      when 'newest'
        order(created_at: :desc)
      else
        order(taggings_count: :desc)
    end
  end

  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings

  validates :title, presence: true

end
