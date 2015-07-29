class User < ActiveRecord::Base
  include Gravtastic

  has_many :questions, foreign_key: :questioner_id
  has_many :answers, foreign_key: :answerer_id
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy
  has_many :votes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniautha１ble
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  gravtastic
end
