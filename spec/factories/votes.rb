FactoryGirl.define do
  factory :vote do
    user_id 1
    votable_id 1
    votable_type 'Question'
    value 1
  end

end
