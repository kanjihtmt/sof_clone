FactoryGirl.define do
  factory :comment do
    body "テストコメント!"
    commentable_type 'Question'
    commentable_id 1
    commenter_id 1
  end
end
