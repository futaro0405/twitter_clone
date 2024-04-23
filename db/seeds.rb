# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

7.times do |n|
  User.find_or_create_by!(id: n) do |user|
    user.name = "username0#{n}"
    user.email = "username0#{n}@example.com"
    user.password = 'password'
    user.telephone = "0801234567#{n}"
    user.birth_date = Date.new(1990, 1, 1)
    user.profile = 'profile_text profile_text profile_text profile_text profile_text profile_text'
    user.location = 'location'
    user.website = 'https://rubyonrails.org/'
    user.uid = "123456789#{n}"
    user.confirmed_at = Time.zone.now
    user.image_avatar = ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join("app/assets/images/icon_user0#{n}.jpg").to_s), filename: "icon_user0#{n}.jpg"
    )
    user.image_cover = ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join("app/assets/images/cover_user0#{n}.jpg").to_s), filename: "cover_user0#{n}.jpg"
    )
  end
end

# 6.times do |m|
#   Post.find_or_create_by!(user_id: m) do |post|
#     post.content = "user_id: #{m} test_content test_content test_content test_content test_content"

#     post.images = ActiveStorage::Blob.create_and_upload!(
#       io: File.open(Rails.root.join('app/assets/images/dummy.jpg').to_s), filename: 'dummy.jpg'
#     )
#   end
# end

# Relationship.find_or_create_by(follow_id: 1) do |user|
#   user.followed_id = 2
# end
