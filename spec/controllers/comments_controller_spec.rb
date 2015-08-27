require 'rails_helper'

shared_examples 'Not login at new action' do
  it "未ログインの場合はコメント出来ないこと" do
    get :new, {commentable_type.downcase + '_id' => commentable.id }
    expect(response).to redirect_to user_session_url
  end
end

shared_examples 'valid render at comment' do
  it "ログインしていればpartialをrenderすること" do
    get :new, {commentable_type.downcase + '_id' => commentable.id }
    expect(response).to render_template(partial: 'comments/_form')
  end
end

shared_examples 'Not login at create action' do
  it "未ログインの場合はコメント出来ないこと" do
    post :create, {commentable_type.downcase + '_id' => commentable.id, comment: {body: 'コメント！コメント！コメント！コメント！', commentable_type: commentable_type, commentable_id: commentable.id} }
    expect(response).to redirect_to user_session_url
  end
end

shared_examples 'Valid comment' do
  it 'は正しくコメントが完了すること' do
    expect {
      post :create, {commentable_type.downcase + '_id' => commentable.id, comment: {body: 'コメント！コメント！コメント！コメント！', commentable_type: commentable_type, commentable_id: commentable.id} }
    }.to change { Comment.count }.by(1)
    expect(response.status).to eq 200
  end
end

shared_examples 'Invalid comment' do
  it 'は投票は行われず、レスポンスコードが422で返り、エラーを表示すること' do
    post :create, {commentable_type.downcase + '_id' => commentable.id,comment: {body: nil, commentable_type: commentable_type, commentable_id: commentable.id} }
    expect(response.status).to eq 422
    expect(JSON.parse(response.body)['messages'].first).to include('を入力してください。')
  end
end

describe CommentsController do
  let(:question) { create(:question) }

  before do
    @user = create(:user, id: 99, name: 'yui123', email: 'yui@example.com')
    @answer = create(:answer, answerer: @user, question: question)
  end

  describe 'GET #new' do
    describe 'Question' do
      it_behaves_like 'Not login at new action' do
        let(:commentable_type) { 'Question' }
        let(:commentable) { question }
      end

      context 'ログイン済み' do
        login_user
        it_behaves_like 'valid render at comment' do
          let(:commentable_type) { 'Question' }
          let(:commentable) { question }
        end
      end
    end

    describe 'Answer' do
      it_behaves_like 'Not login at new action' do
        let(:commentable_type) { 'Answer' }
        let(:commentable) { @answer }
      end

      context 'ログイン済み' do
        login_user
        it_behaves_like 'valid render at comment' do
          let(:commentable_type) { 'Answer' }
          let(:commentable) { @answer }
        end
      end
    end
  end

  describe 'POST #create' do
    describe 'Question' do
      it_behaves_like 'Not login at create action' do
        let(:commentable_type) { 'Question' }
        let(:commentable) { question }
      end

      context 'コメントが有効である場合' do
        login_user
        it_behaves_like 'Valid comment' do
          let(:commentable_type) { 'Question' }
          let(:commentable) { question }
        end
      end

      context 'コメントが無効である場合' do
        login_user
        it_behaves_like 'Invalid comment' do
          let(:commentable_type) { 'Question' }
          let(:commentable) { question }
        end
      end
    end

    describe 'Answer' do
      it_behaves_like 'Not login at create action' do
        let(:commentable_type) { 'Answer' }
        let(:commentable) { @answer }
      end

      context 'コメントが有効である場合' do
        login_user
        it_behaves_like 'Valid comment' do
          let(:commentable_type) { 'Answer' }
          let(:commentable) { @answer }
        end
      end

      context 'コメントが無効である場合' do
        login_user
        it_behaves_like 'Invalid comment' do
          let(:commentable_type) { 'Answer' }
          let(:commentable) { @answer }
        end
      end
    end
  end
end
