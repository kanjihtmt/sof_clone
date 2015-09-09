class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: %i(new create)

  def new
    @comment = Comment.new
    render partial: 'comments/form'
  end

  def create
    @comment = @commentable.comments.build(comment_params.merge(commenter: current_user))

    if @comment.save
      render json: @comment.attributes.merge(commenter: current_user.name,
        created_at: self.class.helpers.time_ago_in_words(@comment.created_at))
    else
      render json: { messages: @comment.errors.full_messages }, status: 422
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :commentable_type, :commentable_id)
    end

    def set_commentable
      klass, id = request.path.split('/')[1, 2]
      @commentable = klass.singularize.classify.constantize.find(id)
      # これは趣味レベルの話になってきますが私だったら次のように実装してみました
      # comment model に COMMENTABLE_CLASSES = [Question, Answer].freeze を追加して
      # klass = Comment::COMMENTABLE_CLASSES.detect{ |c| params["#{c.name.underscore}_id"] }
      # @commentable = klass.find(params["#{klass.name.underscore}_id"])
      # paramsが設定されていたので、せっかくなので使ってみました。
    end
end
