require 'rails_helper'

describe Comment do
  it "はbody, commentable_id, commentable_type, commenter_idが入力されていれば有効な状態であること" do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it "は本文がなければ無効であること" do
    comment = build(:comment, body: nil)
    comment.valid?
    expect(comment.errors[:body]).to include("を入力してください。")
  end

  it "はcommentable_idの入力がなければ無効であること" do
    comment = build(:comment, commentable_id: nil)
    comment.valid?
    expect(comment.errors[:commentable_id]).to include("を入力してください。")
  end

  it "はcommentable_typeの入力がなければ無効であること" do
    comment = build(:comment, commentable_type: nil)
    comment.valid?
    expect(comment.errors[:commentable_type]).to include("を入力してください。")
  end

  it "はコメントした人がいなければ無効であること" do
    comment = build(:comment, commenter_id: nil)
    comment.valid?
    expect(comment.errors[:commenter_id]).to include("を入力してください。")
  end
end
