class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: %i(new create edit update destroy)
  before_action :set_comment, only: %i(edit update destroy)
  before_action :set_question, only: %i(create edit update destroy)

  def new
    @comment = Comment.new
    render partial: 'comments/form'
  end

  def edit
  end

  def create
    @comment = @commentable.comments.build(comment_params)

    if @comment.save
      render partial: 'comment'
      #redirect_to @comment, notice: 'コメントを登録しました。'
    else
      #render template: 'questions/show'
      render partial: 'comment'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'コメントを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'コメントを削除しました。'
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :commenter_id)
    end

    def find_commentable
      klass, id = request.path.split('/')[1, 2]
      @commentable = klass.singularize.classify.constantize.find(id)
    end
end
