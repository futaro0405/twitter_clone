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