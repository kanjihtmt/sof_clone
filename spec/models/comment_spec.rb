require 'rails_helper'

describe Comment do
  it "はbody, commentable_id, commentable_type, commenter_idが入力されていれば有効であること" do
    comment = Comment.new(
      body: 'コメントです。',
      commentable_id: 1,
      commentable_type: 'Question',
      commenter_id: 1)
    expect(comment).to be_valid
  end

  it "は本文がなければ無効であること" do
    comment = Comment.new(body: nil)
    comment.valid?
    expect(comment.errors[:body]).to include("を入力してください。")
  end

  it "はcommentable_idの入力がなければ無効であること" do
    comment = Comment.new(commentable_id: nil)
    comment.valid?
    expect(comment.errors[:commentable_id]).to include("を入力してください。")
  end

  it "はcommentable_typeの入力がなければ無効であること" do
    comment = Comment.new(commentable_type: nil)
    comment.valid?
    expect(comment.errors[:commentable_type]).to include("を入力してください。")
  end

  it "はコメントした人がいなければ無効であること" do
    comment = Comment.new(commenter_id: nil)
    comment.valid?
    expect(comment.errors[:commenter_id]).to include("を入力してください。")
  end
end
