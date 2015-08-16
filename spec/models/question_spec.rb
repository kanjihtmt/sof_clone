require 'rails_helper'

describe Question do
  it '質問はタイトルが必須です.' do
    question = create(:question)
    p Question.find(1)
  end
end
