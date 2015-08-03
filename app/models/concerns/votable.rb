module Votable
  extend ActiveSupport::Concern

  def total_votes_count
    self.upvotes_count - self.downvotes_count
  end

  def upvotes_count
    self.votes.where(value: 1).count
  end

  def downvotes_count
    self.votes.where(value: -1).count
  end
end
