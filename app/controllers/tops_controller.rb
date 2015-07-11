class TopsController < ApplicationController
  def index
    @questions = Question.find_by_tab(params[:tab]).limit(5)
  end
end
