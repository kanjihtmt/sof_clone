class Tagging < ActiveRecord::Base
  belongs_to :question
  belongs_to :tag, counter_cache: true

  validates :question_id, presence: true, uniqueness: { scope: :tag_id }
  validates :tag_id, presence: true
end
