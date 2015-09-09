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
    # clear_vote の中に条件ロジックが含まれてしまっていて、clear_voteという名前以外のことをしてしまっている気がするので
    # after_saveの所を
    # after_save :clear_vote, on: %i(create), if: :canceled_vote?
    # として
    # def canceled_vote?
    #   Vote.where(votable_type: self.votable_type, votable_id: self.votable_id, user_id: self.user_id).pluck(&:value).inject(:+) == 0
    # end
    #
    # def clear_vote
    #   Vote.delete_all(votable_type: self.votable_type, votable_id: self.votable_id, user_id: self.user_id)
    # end
    # とした方が条件とclear_voteのロジックが分かれて理解しやすくなると思います。
    # 途中の所でmapをpluckに変えているのはVoteのObjectを生成するかしないかの違いで無駄なObjectは生成しないようにしています。
end
