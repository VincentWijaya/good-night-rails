# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Seeding database..."

puts "Creating users..."
2.times do |i|
  user = User.create(name: 'User ' + (i + 1).to_s)
  user.save!
  puts "name:#{user.name} api_key: #{user.api_key}"
end

puts "Creating followings..."
following = Following.create(user_id: 1, following_user_id: 2)
following.save!
puts "user_id: #{following.user_id} following_user_id: #{following.following_user_id}"

puts "Creating sleep_trackings..."
3.times do |i|
  clock_in_time = Time.zone.now - rand(1..7).days - 8.hours
  clock_out_time = clock_in_time + 8.hours
  sleep_duration = rand(3600..360000).to_i
  sleep_tracking = SleepTracking.create(user_id: 2, clock_in: clock_in_time, clock_out: clock_out_time, sleep_duration: sleep_duration)
  sleep_tracking.save!
  puts "user_id: #{sleep_tracking.user_id} clock_in: #{sleep_tracking.clock_in} clock_out: #{sleep_tracking.clock_out} sleep_duration: #{sleep_tracking.sleep_duration}"
end
