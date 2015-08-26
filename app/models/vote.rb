class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :value, :votable_id, :votable_type, :user_id, presence: true
  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type], message: 'は2回以上行うことはできません' }
end
