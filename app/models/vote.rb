class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :value, :votable_id, :votable_type, :user_id, presence: true
  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type], message: '同じユーザが2回以上、投票することはできません' }
end