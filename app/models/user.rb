class User < ApplicationRecord
  before_validation :generate_api_key, on: :create

  validates :name, presence: true, format: { with: /\A([-a-zA-Z\d._ ]*)$\z/i, message: 'Format not Supported' }
  validates :api_key, presence: true, uniqueness: true

  has_many :follower, foreign_key: :user_id, class_name: :Following
  has_many :following_users, through: :follower
  has_many :sleep_trackings

  scope :last_week_sleep_trackings, lambda {
    joins(:sleep_trackings)
      .select('sleep_trackings.id, sleep_trackings.user_id, users.name, sleep_trackings.clock_in, sleep_trackings.clock_out, sleep_trackings.sleep_duration')
      .where('sleep_trackings.created_at >= ? AND sleep_trackings.created_at <= ?', 1.week.ago, Time.zone.now)
      .where.not('sleep_trackings.clock_out' => nil)
  }

  private

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64 if api_key.blank?
  end
end
