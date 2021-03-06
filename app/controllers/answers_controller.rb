class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i(edit update destroy)
  before_action :set_question, only: %i(create edit update destroy)

  def preview
    @body = params[:body]
    render partial: 'preview'
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to question_url(@question), notice: '回答が更新されました。'
    else
      render :edit
    end
  end

  def create
    @answer = @question.answers.build(body: answer_params[:body], answerer: current_user)
    if @answer.save
      redirect_to question_url(@question), notice: '回答が登録されました。'
    else
      render template: 'questions/show'
    end
  end

  def destroy
    if @answer.answerer == current_user
      @answer.destroy
      redirect_to question_url(@answer.question), notice: '回答を削除しました。'
    else
      redirect_to question_url(@answer.question), alert: '他の人の回答は削除できません。'
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def set_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:body)
    end
end
