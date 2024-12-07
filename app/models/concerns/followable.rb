module Followable
  extend ActiveSupport::Concern

  included do
    has_many :user_followees, foreign_key: :followee_id, class_name: "UserFollow"
    has_many :user_followers, foreign_key: :follower_id, class_name: "UserFollow"

    has_many :followers, through: :user_followees, class_name: "User"
    has_many :followees, through: :user_followers, class_name: "User"
  end
end
