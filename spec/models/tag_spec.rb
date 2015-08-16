require 'rails_helper'

describe Tag do
  it 'titleが入力されていれば有効であること' do
    tag = build(:tag)
    expect(tag).to be_valid
  end

  it 'titleが入力されてなければ無効であること' do
    tag = build(:tag, title: nil)
    tag.valid?
    expect(tag.errors[:title]).to include('を入力してください。')
  end

  it '名前でソートした場合、名前の昇順でリストされていること' do
    tags = %w(aaaa bbbb cccc dddd eeee ffff)
    tags.shuffle.each do |title|
      create(:tag, title: title)
    end
    tags = Tag.sort('name').map(&:title)
    expect(tags).to eq(%w(aaaa bbbb cccc dddd eeee ffff))
  end

  it '人気でソートした場合、人気の高い順にリストされていること' do
    create(:tag, title: 'java', taggings_count: 5)
    create(:tag, title: 'ruby', taggings_count: 20)
    create(:tag, title: 'python', taggings_count: 10)
    create(:tag, title: 'php', taggings_count: 50)
    create(:tag, title: 'javascript', taggings_count: 100)
    tags = Tag.sort('popular').map(&:title)
    expect(tags).to eq(%w(javascript php ruby python java))
  end

  it '新規でソートした場合、新規登録順にリストされていること' do
    create(:tag, title: 'java',       created_at: Time.now - 5.day)
    create(:tag, title: 'ruby',       created_at: Time.now - 4.day)
    create(:tag, title: 'python',     created_at: Time.now - 3.day)
    create(:tag, title: 'php',        created_at: Time.now - 2.day)
    create(:tag, title: 'javascript', created_at: Time.now - 1.day)
    tags = Tag.sort('newest').map(&:title)
    expect(tags).to eq(%w(javascript php python ruby java))
  end
end
