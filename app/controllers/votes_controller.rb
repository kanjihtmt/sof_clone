class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_votable, only: %i(create)

  def create
    @vote = current_user.votes.build(vote_params)
    if @vote.save
      render json: {votes_count: @votable.total_votes_count}
    else
      render json: { messages: @vote.errors.full_messages }, status: 422
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:value, :votable_type, :votable_id)
    end

    def set_votable
      klass, id = request.path.split('/')[1, 2]
      @votable = klass.singularize.classify.constantize.find(id)
    end
end
