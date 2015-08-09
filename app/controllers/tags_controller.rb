class TagsController < ApplicationController
  def index
    @tags = Tag.search(title_cont: params[:keyword]).result.sort(params[:tab])
    render partial: 'tags' if request.xhr?
  end
end
