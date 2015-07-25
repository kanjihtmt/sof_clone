class TagsController < ApplicationController

  def index
    #@tags = Tag.all.order(tagging_count: :desc)
    @tags = Tag.all
  end
end
