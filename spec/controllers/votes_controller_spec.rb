require 'rails_helper'

shared_examples 'Not login' do
  it "未ログインの場合は投票出来ないこと" do
    post :create, {votable_type.downcase + '_id' => votable.id, vote: {value: 1, votable_type: votable_type, votable_id: votable.id} }
    expect(response).to redirect_to user_session_url
  end
end

shared_examples 'Valid vote' do
  it 'は正しく投票が完了すること' do
    expect {
      post :create, {votable_type.downcase + '_id' => votable.id, vote: {value: 1, votable_type: votable_type, votable_id: votable.id} }
    }.to change { Vote.count }.by(1)
    expect(response.status).to eq 200
    expect(JSON.parse(response.body)['votes_count']).to eq 1
  end
end

shared_examples 'Invalid vote' do
  it 'は投票は行われず、レスポンスコードが422で返り、エラーを表示すること' do
    post :create, {votable_type.downcase + '_id' => votable.id, vote: {value: 1, votable_type: votable_type, votable_id: nil} }
    expect(response.status).to eq 422
    expect(JSON.parse(response.body)['messages'].first).to include('を入力してください。')
  end
end

describe VotesController do
  describe 'POST #create' do
    let!(:question) { create(:question) }

    describe 'Question' do
      it_behaves_like 'Not login' do
        let(:votable_type) { 'Question' }
        let(:votable) { question }
      end

      context '投票が有効である場合' do
        login_user
        it_behaves_like 'Valid vote' do
          let(:votable_type) { 'Question' }
          let(:votable) { question }
        end
      end

      context '投票が無効である場合' do
        login_user
        it_behaves_like 'Invalid vote' do
          let(:votable_type) { 'Question' }
          let(:votable) { question }
        end
      end
    end

    describe 'Answer' do
      before do
        @user = create(:user, id: 99, name: 'yui123',
                       email: 'yui@example.com', password: 'yui12345')
        @answer = create(:answer, answerer: @user, question: question)
      end

      it_behaves_like 'Not login' do
        let(:votable_type) { 'Answer' }
        let(:votable) { @answer }
      end

      context '投票が有効である場合' do
        login_user
        it_behaves_like 'Valid vote' do
          let(:votable_type) { 'Answer' }
          let(:votable) { @answer }
        end
      end

      context '投票が無効である場合' do
        login_user
        it_behaves_like 'Invalid vote' do
          let(:votable_type) { 'Answer' }
          let(:votable) { @answer }
        end
      end
    end
  end
end
