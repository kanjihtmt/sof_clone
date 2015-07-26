class TagsController < ApplicationController
  def index
    @tags = Tag.find_by_keyword_and_tab(params[:keyword], params[:tab])
    render partial: 'tags' if request.xhr?
  end
end
