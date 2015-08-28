require 'rails_helper'

# search_questions     GET    /questions/search(.:format)                       questions#search
# unanswered_questions GET    /questions/unanswered(.:format)                   questions#unanswered
# preview_questions    POST   /questions/preview(.:format)                      questions#preview
# accept_question      POST   /questions/:id/accept(.:format)                   questions#accept
# questions            GET    /questions(.:format)                              questions#index
#                      POST   /questions(.:format)                              questions#create
# new_question         GET    /questions/new(.:format)                          questions#new
# edit_question        GET    /questions/:id/edit(.:format)                     questions#edit
# question             GET    /questions/:id(.:format)                          questions#show
#                      PATCH  /questions/:id(.:format)                          questions#update
#                      PUT    /questions/:id(.:format)                          questions#update
describe QuestionsController do
  describe '未ログイン' do
    describe 'GET #index' do
    end

    describe 'GET #search' do
    end

    describe 'GET #unanswered' do
    end
  end

  describe 'ログイン' do
    login_user
    describe 'POST #create' do
    end
  end
end
