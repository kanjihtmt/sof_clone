class TopsController < ApplicationController
  before_action :set_tags, only: %i(index)
  before_action :set_default_sort, only: %i(index)

  def index
    @questions = Question.includes(:questioner, :tags).sort(params[:tab]).limit(TOP_PAGE_MAX)
  end

  private
    def set_default_sort
      params[:tab] ||= 'active'
    end
end
