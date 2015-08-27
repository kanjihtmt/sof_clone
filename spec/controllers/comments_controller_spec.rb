require 'rails_helper'

describe CommentsController do
  describe 'GET #new' do
    let(:user) { build(:user) }
    let(:question) { create(:question) }

    describe 'Question' do
      context '未ログイン' do
        it "未ログインの場合はアクセスできないこと" do
          get :new, { :question_id => question.id }
          expect(response).to redirect_to user_session_url
        end
      end

      context 'ログイン済み' do
        login_user
        it "ログインしていればpartialをrenderすること" do
          get :new, { question_id: question.id }
          expect(response).to render_template(partial: 'comments/_form')
        end
      end
    end

    describe 'Answer' do
      before do
        @answer = create(:answer, answerer: user, question: question)
      end
      #@user = create(:user, id: 99, name: 'yui123',
      #               email: 'yui@example.com', password: 'yui12345')
    end
  end
end
