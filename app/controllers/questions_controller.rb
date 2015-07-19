class QuestionsController < ApplicationController
  before_action :set_question, only: %i(show edit update destroy)
  before_action :set_tags, only: %i(index)

  def index
    #TODO: 投票数を求める処理をモデルに書くこと
    @questions = Question.includes(:questioner, :tags).all.order(updated_at: :desc)
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

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
    redirect_to questions_url, notice: '質問が削除されました。'
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, :best_answer_id, :user_id)
    end
end
