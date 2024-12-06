class User < ApplicationRecord
  before_validation :generate_api_key, on: :create

  private

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64 if key.blank?
  end
end
