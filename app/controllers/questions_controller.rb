class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i(index unanswered show search)
  before_action :set_question, only: %i(show edit update accept)
  before_action :set_tags, only: %i(index unanswered tagged search)

  def index
    @questions = Question.page(params['page']).per(PAGE_MAX)
                  .includes(:questioner, :tags).sort(params[:tab])
  end

  def unanswered
    @questions = Question.page(params['page']).per(PAGE_MAX)
                  .includes(:questioner, :tags).sort('unanswered')
    render :index
  end

  def tagged
    @questions = Question.page(params['page']).per(PAGE_MAX)
                  .includes(:questioner, :tags).joins(:tags)
                  .where('tags.title = ?', params[:tag]).order(created_at: :desc)
    render :index
  end

  def search
    @questions = Question.search(title_or_body_cont: params[:keyword]).result
                    .page(params['page']).per(PAGE_MAX).includes(:questioner, :tags)
    render :index
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

  def accept
    if @question.questioner != current_user
      redirect_to @question, alert: '自分の質問の回答でなければ承認できません。' and return
    end

    @question.best_answer = @question.answers.find(question_params[:best_answer_id])
    if @question.save
      redirect_to @question, notice: '選択した回答を承認しました。'
    else
      render :show
    end
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

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :body, :tag_list, :questioner_id, :best_answer_id)
    end
end
