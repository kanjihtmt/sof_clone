require 'rails_helper'

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
      it 'データが更新されていること' do
        patch :update, question_id: @question, id: @answer,
          answer: {body: '良く確認して下さい!しっかりエラーをよくみましょう！'}
        @answer.reload
        expect(@answer.body).to eq '良く確認して下さい!しっかりエラーをよくみましょう！'
      end
      it '質問詳細ページにリダレクトされていること' do
        patch :update, question_id: @question, id: @answer,
          answer: {body: '良く確認して下さい!しっかりエラーをよくみましょう！'}
        expect(response).to redirect_to question_url(@question)
      end
      it '質問詳細ページ更新完了メッセージが表示されていること' do
        patch :update, question_id: @question, id: @answer,
          answer: {body: '良く確認して下さい!しっかりエラーをよくみましょう！'}
        expect(flash[:notice]).to be_present
      end
    end

    context '回答の更新に失敗した場合' do
      it 'データは更新されていないこと' do
        patch :update, question_id: @question, id: @answer,
          answer: {body: 'バリデーションが通らない短い回答'}
        @answer.reload
        expect(@answer.body).not_to eq 'バリデーションが通らない短い回答'
      end
      it '再度編集画面が表示されていること' do
        patch :update, question_id: @question, id: @answer,
          answer: {body: 'バリデーションが通らない短い回答'}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'POST #create' do
    context '回答の新規登録に成功した場合' do
      it 'データが登録されていること' do
        expect {
          post :create, question_id: @question,
            answer: {body: '良く確認して下さい!しっかりエラーをよくみましょう！'}
        }.to change(Answer, :count).by(1)
      end
      it '質問詳細ページにリダレクトされていること ' do
        post :create, question_id: @question,
          answer: {body: '良く確認して下さい!しっかりエラーをよくみましょう！'}
        expect(response).to redirect_to question_url(@question)
      end
      it '質問詳細ページに登録完了メッセージが表示されていること' do
        post :create, question_id: @question,
          answer: {body: '良く確認して下さい!しっかりエラーをよくみましょう！'}
        expect(flash[:notice]).to be_present
      end
    end

    context '回答の新規登録に失敗した場合' do
      it 'データは登録されていないこと' do
        expect {
          post :create, question_id: @question,
            answer: {body: 'バリデーションが通らない短い回答'}
        }.to change(Answer, :count).by(0)
      end
      it '質問詳細画面が表示されていること' do
        post :create, question_id: @question,
          answer: {body: 'バリデーションが通らない短い回答'}
        expect(response).to render_template('questions/show')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      user = build(:user)
      @answer_of_loginuser = create(:answer, answerer: user, question: @question)
    end

    context '自分の回答を削除する場合' do
      it '回答が削除されていること' do
        expect {
          delete :destroy, question_id: @question, id: @answer_of_loginuser
        }.to change(Answer, :count).by(-1)
      end
      it '質問詳細ページにリダイレクトされていること' do
        delete :destroy, question_id: @question, id: @answer_of_loginuser
        expect(response).to redirect_to(question_url(@question))
      end
      it '質問詳細ページに削除完了メッセージが表示されていること' do
        delete :destroy, question_id: @question, id: @answer_of_loginuser
        expect(flash[:notice]).to be_present
      end
    end

    context '自分の回答を削除する場合' do
      it '回答が削除されていないこと' do
        expect {
          delete :destroy, question_id: @question, id: @answer
        }.not_to change(Answer, :count)
      end
      it '質問詳細ページにリダイレクトされていること' do
        delete :destroy, question_id: @question, id: @answer
        expect(response).to redirect_to(question_url(@question))
      end
      it '質問詳細ページにエラー表示がされていること' do
        delete :destroy, question_id: @question, id: @answer
        expect(flash[:alert]).to be_present
      end
    end
  end
end
