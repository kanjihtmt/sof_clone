class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :set_question, only: %i(show edit update destroy)
  before_action :set_tags, only: %i(index)

  def index
    #@questions = Question.includes(:questioner, :tags).all.order(updated_at: :desc)
    @questions = Question.page(params['page']).per(5).includes(:questioner, :tags).all.order(updated_at: :desc)
  end

  def show
    impressionist(@question, nil, :unique => [:session_hash])
    @answer = @question.answers.build
  end

  def new
    @question = current_user.questions.build
  end

  def edit
  end

  def preview
    @body = params[:body]
    render partial: 'preview'
  end

  def create
    @question = current_user.questions.build question_params

    if @question.save
      redirect_to @question, notice: '質問が作成されました。'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: '質問が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to @questions, notice: '質問が削除されました。'
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, :tag_list)
    end
end
