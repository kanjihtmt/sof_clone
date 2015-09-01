require 'rails_helper'

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
        create(:question, title: 'rubyでバッチ処理を実行したい')
        get :search, keyword: 'ru'
        expect(response).to render_template :index
      end

      it '検索した質問内容を取得すること' do
        ruby = create(:question, title: 'rubyでスクレイピングがしたい')
        rails = create(:question, title: 'railsでバリデーションがうまくいきません')
        create(:question, title: 'nginxが不安定です')
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
        ruby = create(:question, title: 'rubyでスクレイピングがしたい')
        rails = create(:question, title: 'railsでバリデーションがうまくいきません')
        nginx = create(:question, title: 'nginxが不安定です')
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
      @login_user = build(:user)
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
      context '自分の質問で承認する' do
        before do
          @valid_question = create(:question, questioner: @login_user)
          answerer = create(:user, id: 2, email: 'yui@example.com')
          @answer = create(:answer, answerer: answerer, question: @valid_question)
        end

        it '承認が可能なこと' do
          post :accept, id: @valid_question, question: { best_answer_id: @answer }
          expect(flash[:notice]).to be_present
        end

        it '質問詳細画面にリダイレクトすること' do
          post :accept, id: @valid_question, question: { best_answer_id: @answer }
          expect(response).to redirect_to question_url(@valid_question)
        end
      end

      context '他人の質問で承認する' do
        before do
          other = create(:user, id: 2, email: 'akiko@example.com')
          @invalid_question = create(:question, questioner: other)
          answerer = create(:user, id: 3, email: 'yui@example.com')
          @answer = create(:answer, answerer: answerer, question: @invalid_question)
        end

        it '承認ができないこと' do
          post :accept, id: @invalid_question, question: { best_answer_id: @answer }
          expect(flash[:alert]).to be_present
        end

        it '質問詳細画面にリダイレクトすること' do
          post :accept, id: @invalid_question, question: { best_answer_id: @answer }
          expect(response).to redirect_to question_url(@invalid_question)
        end
      end
    end

    describe 'POST #preview' do
      it '質問文をPOSTすると部分テンプレートを表示すること' do
        post :preview, id: @question, body: 'たのしいRuby'
        expect(response).to render_template(partial: '_preview')
      end

      it 'POSTした質問の本文にビューからアクセスできること' do
        post :preview, id: @question, body: 'たのしいRuby'
        expect(assigns(:body)).to eq 'たのしいRuby'
      end
    end

    describe 'POST #create' do
      context '質問の登録に成功した場合' do
        it 'データが登録されていること' do
          expect {
            post :create, question: attributes_for(:question)
          }.to change(Question, :count).by(1)
        end

        it '質問詳細ページにリダレクトされていること ' do
          post :create, question: attributes_for(:question)
          expect(response).to redirect_to question_path(assigns[:question])
        end

        it '質問詳細ページに登録完了メッセージが表示されていること' do
          post :create, question: attributes_for(:question)
          expect(flash[:notice]).to be_present
        end
      end

      context '質問の登録に失敗した場合' do
        it 'データは登録されていないこと' do
          expect {
            post :create, question: attributes_for(:question, title: 'エラータイトル')
          }.to change(Question, :count).by(0)
        end

        it '質問登録画面が表示されていること' do
          post :create, question: attributes_for(:question, title: 'エラータイトル')
          expect(response).to render_template :new
        end
      end
    end

    describe 'POST #update' do
      context '質問の更新に成功した場合' do
        it 'データが更新されていること' do
          patch :update, id: @question, question: attributes_for(:question, title: 'タイトル変更タイトル変更')
          @question.reload
          expect(@question.title).to eq('タイトル変更タイトル変更')
        end

        it '質問詳細ページにリダレクトされていること' do
          patch :update, id: @question, question: attributes_for(:question, title: 'タイトル変更タイトル変更')
          expect(response).to redirect_to question_path(@question)
        end

        it '質問詳細ページ更新完了メッセージが表示されていること' do
          patch :update, id: @question, question: attributes_for(:question, title: 'タイトル変更タイトル変更')
          expect(flash[:notice]).to be_present
        end
      end

      context '質問の更新に失敗した場合' do
        it 'データは更新されていないこと' do
          patch :update, id: @question, question: attributes_for(:question, title: 'エラータイトル')
          @question.reload
          expect(@question.title).not_to eq('エラータイトル')
        end

        it '再度編集画面が表示されていること' do
          patch :update, id: @question, question: attributes_for(:question, title: 'エラータイトル')
          expect(response).to render_template :edit
        end
      end
    end
  end
end
