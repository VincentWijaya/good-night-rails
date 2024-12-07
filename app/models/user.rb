class User < ApplicationRecord
  include Followable

  before_validation :generate_api_key, on: :create

  validates :name, presence: true, format: { with: /\A([-a-zA-Z\d._ ]*)$\z/i, message: 'Format not Supported' }
  validates :api_key, presence: true, uniqueness: true
  has_many :sleep_trackings

  private

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64 if api_key.blank?
  end
end
