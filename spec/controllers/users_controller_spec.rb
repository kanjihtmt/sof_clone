require 'rails_helper'

describe UsersController do
  before do
    @users = []
    @dhh = create(:user, id: 1, name: 'david', email: 'david@example.com')
    @kanji = create(:user, id: 2, name: 'kanji', email: 'kanji@example.com')
    @users << @dhh
    @users << @kanji
  end

  describe 'GET #index' do
    it 'ユーザ一覧が正しく表示されること' do
      get :index
      expect(response).to render_template('index')
    end

    it 'ユーザの全件が取得できること' do
      get :index
      expect(assigns(:users)).to match_array(@users)
    end

    it 'キーワード検索ができること' do
      get :index, keyword: 'dav'
      expect(assigns(:users)).to match_array(@dhh)
    end
  end

  describe 'GET #show' do
    it 'ユーザ詳細が正しく表示されること' do
      get :show, id: @dhh
      expect(response).to render_template('show')
    end
  end
end
