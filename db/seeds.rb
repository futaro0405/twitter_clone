# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

7.times do |n|
  User.find_or_create_by!(name: "username0#{n}") do |user|
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

User.all.each do |user|
  3.times do |m|
    Post.create!(
      user_id: user.id,
      content: "No. #{m} test content",
      images: ActiveStorage::Blob.create_and_upload!(
        io: File.open(Rails.root.join('app/assets/images/dummy.jpg').to_s), filename: 'dummy.jpg'
      )
    )
  end
end

target_user = User.find_by(name: 'username00')
(3..6).each do |num|
  target_user.follow(num)
end

User.all.each do |user|
  unless user.equal?(target_user)
    Favorite.find_or_create_by!(user_id: user.id) do |favorite|
      favorite.post_id = 1
    end
    Repost.find_or_create_by!(user_id: user.id) do |repost|
      repost.post_id = 1
    end
  end
  Comment.find_or_create_by!(user_id: user.id) do |comment|
    comment.post_id = 1
    comment.comment_content = 'comment_text comment_text comment_text'
  end
end
