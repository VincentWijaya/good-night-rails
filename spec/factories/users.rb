FactoryBot.define do
  factory :user do
    name { 'John doe' }
    api_key { SecureRandom.hex }
  end
end
