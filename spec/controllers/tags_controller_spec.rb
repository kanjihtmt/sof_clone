require 'rails_helper'

describe TagsController do
  before do
    @tags = []
    @rails = create(:tag, title: 'rails')
    @ruby = create(:tag, title: 'ruby')
    @php = create(:tag, title: 'php')
    @tags << @rails
    @tags << @ruby
    @tags << @php
  end

  describe 'GET #index' do
    it 'タグ一覧が正しく表示されること' do
      get :index
      expect(response).to render_template('index')
    end

    it 'タグの全件が取得できること' do
      get :index
      expect(assigns(:tags)).to match_array(@tags)
    end

    it 'キーワード検索ができること' do
      get :index, keyword: 'php'
      expect(assigns(:tags)).to match_array(@php)
    end
  end
end
