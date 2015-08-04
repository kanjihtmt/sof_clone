class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: %i(new create edit update destroy)

  def new
    @comment = Comment.new
    render partial: 'comments/form'
  end

  def create
    @comment = @commentable.comments.build(comment_params.merge(commenter: current_user))

    if @comment.save
      #redirect_to @comment, notice: 'コメントを登録しました。'
    else
      #render partial: 'comment'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end

    def find_commentable
      klass, id = request.path.split('/')[1, 2]
      @commentable = klass.singularize.classify.constantize.find(id)
    end
end
