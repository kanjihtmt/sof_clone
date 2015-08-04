class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_votable

  def new
    @vote = Vote.new
  end

  def create
    @vote = current_user.votes.build(vote_params)
    if @vote.save
      render json:  {votes_count: @votable.total_votes_count, message: '投票されました。'}
    else
      render json: {message: '投票に失敗しました。'}
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:value, :votable_type, :votable_id)
    end

    def find_votable
      klass, id = request.path.split('/')[1, 2]
      @votable = klass.singularize.classify.constantize.find(id)
    end
end