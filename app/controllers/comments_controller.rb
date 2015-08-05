class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: %i(create)

  def new
    @comment = Comment.new
    render partial: 'comments/form'
  end

  def create
    @comment = @commentable.comments.build(comment_params.merge(commenter: current_user))

    if @comment.save
      render json: @comment.attributes
    else
      render json: { error_message: @comment.errors.attributes.first }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end

    def set_commentable
      klass, id = request.path.split('/')[1, 2]
      @commentable = klass.singularize.classify.constantize.find(id)
    end
end
