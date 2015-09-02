class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :value, :votable_id, :votable_type, :user_id, presence: true
  validates :user_id, uniqueness: {
    scope: [:votable_id, :votable_type, :value],
    message: 'は2回以上行うことはできません' }

  after_save :clear_vote, on: %i(create)

  protected
    def clear_vote
      values = Vote.where(votable_type: self.votable_type, votable_id: self.votable_id,
                  user_id: self.user_id).map(&:value)
      Vote.delete_all(votable_type: self.votable_type,
        votable_id: self.votable_id, user_id: self.user_id) if values.inject(:+) == 0
    end
end
