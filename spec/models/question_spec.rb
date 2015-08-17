require 'rails_helper'

describe Question do
  it 'はタイトル、本文、質問者、タグの入力があれば有効であること' do
    question = build(:question)
    expect(question).to be_valid
  end

  it 'はタイトルがなければ無効であること' do
    question = build(:question, title: nil)
    question.valid?
    expect(question.errors[:title]).to include("を入力してください。")
  end

  it 'はタイトルが8文字以上でなければ無効であること' do
    question = build(:question, title: '１２３４５６７')
    question.valid?
    expect(question.errors[:title]).to include("は8文字以上で入力してください。")
  end

  it 'は本文がなければ無効であること' do
    question = build(:question, body: nil)
    question.valid?
    expect(question.errors[:body]).to include("を入力してください。")
  end

  it 'は本文が20文字以上でなければ無効であること' do
    question = build(:question, body: '１２３４５６７８９０１２３４５６７８９')
    question.valid?
    expect(question.errors[:body]).to include("は20文字以上で入力してください。")
  end

  it 'は質問者の関連がなければ無効であること' do
    question = build(:question, questioner_id: nil)
    question.valid?
    expect(question.errors[:questioner_id]).to include("を入力してください。")
  end

  it 'は1つ以上のタグがなければ無効であること' do
    question = build(:question, tag_list: nil)
    question.valid?
    expect(question.errors[:tag_list]).to include("少なくとも1つ以上のタグを入力してください。")
  end

  it 'は保存前にtagsに関連が入っていること' do
    question = build(:question)
    question.save!
    expect(question.tags.map(&:title)).to eq ['rails', 'ruby']
  end

  it 'は検索時にtag_listを設定すること' do
    create(:question)
    question = Question.find_by(title: "質問テストタイトル")
    expect(question.tag_list).to eq 'rails,ruby'
  end
end
