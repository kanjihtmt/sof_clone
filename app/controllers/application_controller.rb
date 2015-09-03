class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'],
    :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"

  private
    def set_tags
      @tags = Tag.order(updated_at: :desc)
    end

    def set_default_sort
      params[:tab] ||= 'active'
    end
end
