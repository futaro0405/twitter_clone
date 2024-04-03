# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

nicknames = ['ごとう', 'いじち', 'やまだ', 'きた', ]

nicknames.each_with_index do |nickname, index|
  account = "2seeds#{index + 1}"
  find_or_create_user(account, nickname)
end

3.times do |n|
  User.find_or_create_by!(name: "USER-0#{n}") do |user|
    user.email = "username0#{n}@example.com"
    user.password = "password"
    user.telephone = "0801234567#{n}"
    user.birth_date = Date.new(1990, 1, 1)
  end
end

