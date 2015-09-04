class TopsController < ApplicationController
  before_action :set_tags, only: %i(index)
  before_action :set_default_sort, only: %i(index)

  def index
    @questions = Question.includes(:questioner, :tags).interval(params[:tab])
                   .sort(params[:tab]).limit(TOP_PAGE_MAX)
  end
end
