# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

3.times do |n|
  User.find_or_create_by!(name: "USER-0#{n}") do |user|
    user.email = "username0#{n}@example.com"
    user.password = "password"
    user.telephone = "0801234567#{n}"
    user.birth_date = Date.new(1990, 1, 1)
    user.profile = "profile profile profile"
    user.profile = "location"
    user.profile = "website"
    user.image_avatar = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/dummy.jpg').to_s), filename: 'dummy.jpg')
    user.image_cover = ActiveStorage::Blob.create_and_upload!(io: File.open(Rails.root.join('app/assets/images/dummy.jpg').to_s), filename: 'dummy.jpg')
  end
end
