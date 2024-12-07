FactoryBot.define do
  factory :sleep_tracking do
    clock_in { Time.zone.now }
    clock_out { Time.zone.now + (1).days }
    sleep_duration { clock_out.present? ? clock_out - clock_in : nil }
    user
  end
end
