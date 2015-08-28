require 'rails_helper'

#preview_question_answers POST   /questions/:question_id/answers/preview(.:format) answers#preview
#        question_answers POST   /questions/:question_id/answers(.:format)         answers#create
#   edit_question_answers GET    /questions/:question_id/answers/edit(.:format)    answers#edit
#                         PATCH  /questions/:question_id/answers(.:format)         answers#update
#                         PUT    /questions/:question_id/answers(.:format)         answers#update
#                         DELETE /questions/:question_id/answers(.:format)         answers#destroy

describe AnswersController do
  login_user

  before do
    @question = create(:question)
    user = create(:user, id: 2, email: 'dave@pragmatic.com')
    @answer = create(:answer, answerer: user, question: @question)
  end

  describe 'POST #preview' do
    it '回答文をPOSTすると部分テンプレートを表示すること' do
      post :preview, question_id: @question, body: 'たのしいRuby'
      expect(response).to render_template(partial: '_preview')
    end

    it 'POSTした本文にビューからアクセスできること' do
      post :preview, question_id: @question, body: 'たのしいRuby'
      expect(assigns(:body)).to eq 'たのしいRuby'
    end
  end

  describe 'GET #edit' do
    it '編集画面が表示されること' do
      get :edit, question_id: @question, id: @answer
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    context '回答の更新に成功した場合' do
      it 'データが更新されていること'
      it '質問詳細ページにリダレクトされていること'
      it '質問詳細ページ更新完了メッセージが表示されていること'
    end

    context '回答の更新に失敗した場合' do
      it 'データは更新されていないこと'
      it '再度編集画面が表示されていること'
    end
  end

  describe 'POST #create' do
    context '回答の新規登録に成功した場合' do
      it 'データが登録されていること'
      it '質問詳細ページにリダレクトされていること'
      it '質問詳細ページに登録完了メッセージが表示されていること'
    end

    context '回答の新規登録に失敗した場合' do
      it 'データは登録されていないこと'
      it '質問詳細画面が表示されていること'
    end
  end

  describe 'DELETE #destroy' do
    context '自分の回答を削除する場合' do
      it '回答が削除されていること'
      it '質問詳細ページにリダイレクトされていること'
      it '質問詳細ページに削除完了メッセージが表示されていること'
    end

    context '自分の回答を削除する場合' do
      it '回答が削除されていないこと'
      it '質問詳細ページにリダイレクトされていること'
      it '質問詳細ページにエラー表示がされていること'
    end
  end
end
