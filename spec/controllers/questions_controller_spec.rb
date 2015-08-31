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
  describe '未ログインでのアクセス' do
    before do
      @question = create(:question)
    end

    describe 'GET #index' do
      it 'indexテンプレートを表示すること' do
        get :index
        expect(response).to render_template :index
      end
      it '質問内容を取得すること' do
        get :index
        expect(assigns(:questions)).to match_array([@question])
      end
    end

    describe 'GET #search' do
      it 'indexテンプレートを表示すること' do
        create(:question, id: 2, title: 'rubyでバッチ処理を実行したい')
        get :search, keyword: 'ru'
        expect(response).to render_template :index
      end
      it '検索した質問内容を取得すること' do
        ruby = create(:question, id: 2, title: 'rubyでスクレイピングがしたい')
        rails = create(:question, id: 3, title: 'railsでバリデーションがうまくいきません')
        create(:question, id: 4, title: 'nginxが不安定です')
        get :search, keyword: 'r'
        expect(assigns(:questions)).to match_array([rails, ruby])
      end
    end

    describe 'GET #unanswered' do
      it 'indexテンプレートを表示すること' do
        get :unanswered
        expect(response).to render_template :index
      end
      it '未回答の質問内容を取得すること' do
        # 質問
        ruby = create(:question, id: 2, title: 'rubyでスクレイピングがしたい')
        rails = create(:question, id: 3, title: 'railsでバリデーションがうまくいきません')
        nginx = create(:question, id: 4, title: 'nginxが不安定です')
        # 回答者
        dave = create(:user, id: 2, email: 'dave@pragmatic.com')
        dhh = create(:user, id: 3, email: 'david@basecamp.com')
        # 回答
        create(:answer, answerer: dave, question: ruby)
        create(:answer, answerer: dhh, question: rails)

        get :unanswered
        expect(assigns(:questions)).to match_array([nginx, @question])
      end
    end

    describe 'GET #show' do
      it 'showテンプレートを表示すること' do
        get :show, id: @question
        expect(response).to render_template :show
      end
      it '指定された質問を取得すること' do
        get :show, id: @question
        expect(assigns(:question)).to eq @question
      end
    end

    describe 'GET #new' do
      it 'アクセスできないこと' do
        get :new
        expect(response).to redirect_to user_session_url
      end
    end

    describe 'GET #edit' do
      it 'アクセスできないこと' do
        get :edit, id: @question
        expect(response).to redirect_to user_session_url
      end
    end

    describe 'POST #accept' do
      it 'アクセスできないこと' do
        post :accept, id: @question, question: { best_answer_id: 1 }
        expect(response).to redirect_to user_session_url
      end
    end

    describe 'POST #preview' do
      it 'アクセスできないこと' do
        post :preview, body: 'たのしいRuby'
        expect(response).to redirect_to user_session_url
      end
    end

    describe 'POST #create' do
      it 'アクセスできないこと' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to user_session_url
      end
    end

    describe 'POST #update' do
      it 'アクセスできないこと' do
        post :create, id: @question, question: attributes_for(:question)
        expect(response).to redirect_to user_session_url
      end
    end
  end

  describe 'ログイン済みのアクセス' do
    login_user

    before do
      @question = create(:question)
    end

    describe 'GET #new' do
      it '新規登録画面が表示されること' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it '編集画面が表示されること' do
        get :edit, id: @question
        expect(response).to render_template :edit
      end
    end

    describe 'POST #accept' do
      #post :accept, id: @question, question: { best_answer_id: 1 }
      context '自分の質問で承認する' do
        it '承認が可能なこと'
        it '質問詳細画面にリダイレクトすること'
      end

      context '他人の質問で承認する' do
        it '承認ができないこと'
        it '質問詳細画面にリダイレクトすること'
      end
    end

    describe 'POST #preview' do
      it '質問文をPOSTすると部分テンプレートを表示すること'
      it 'POSTした質問の本文にビューからアクセスできること'
    end

    describe 'POST #create' do
      context '質問の登録に成功した場合' do
        it 'データが登録されていること'
        it '質問詳細ページにリダレクトされていること '
        it '質問詳細ページに登録完了メッセージが表示されていること'
      end

      context '質問の登録に失敗した場合' do
        it 'データは登録されていないこと'
        it '質問詳細画面が表示されていること'
      end
    end

    describe 'POST #update' do
      #post :create, id: @question, question: attributes_for(:question)
      context '質問の更新に成功した場合' do
        it 'データが更新されていること'
        it '質問詳細ページにリダレクトされていること'
        it '質問詳細ページ更新完了メッセージが表示されていること'
      end

      context '質問の更新に失敗した場合' do
        it 'データは更新されていないこと'
        it '再度編集画面が表示されていること'
      end
    end
  end
end
