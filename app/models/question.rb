class Question < ActiveRecord::Base
  scope :active, -> { order(updated_at: :desc, created_at: :desc) }

  belongs_to :user

  def self.find_by_tab(tab)
    case tab
      when :active
        @questions = self.active
      when :hot
        @questions = self.all
      when :week
        @questions = self.all
      when :month
        @questions = self.all
      else
        @questions = self.all
    end
    @questions
  end
end
