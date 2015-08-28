class TopsController < ApplicationController
  before_action :set_tags, only: %i(index)

  def index
    @questions = Question.includes(:questioner, :tags).sort(params[:tab]).limit(TOP_PAGE_MAX)
  end
end
