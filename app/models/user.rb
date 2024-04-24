# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_image_avatar
  before_create :set_image_cover

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

  with_options presence: true do
    validates :name
    validates :telephone
    validates :birth_date
  end
  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  has_one_attached :image_avatar
  has_one_attached :image_cover
  has_many :posts, dependent: :destroy

  has_many :relationships,            class_name: 'Relationship', foreign_key: :follow_id,    dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id,  dependent: :destroy

  has_many :followings, through: :relationships,            source: :followed
  has_many :followers,  through: :reverse_of_relationships, source: :follow

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.telephone = '00000000000'
      user.birth_date = '1000-01-01'

      if user.persisted? || auth.provider == 'github'
        user.skip_confirmation! if auth.provider == 'github'
        user.save
      end
    end
  end

  # フォロー処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外す処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  private

  def set_image_avatar
    return if image_avatar.attached?

    file_path = Rails.root.join('app/assets/images/dummy.jpg')
    image_avatar.attach(io: File.open(file_path), filename: 'dummy.jpg')
  end

  def set_image_cover
    return if image_cover.attached?

    file_path = Rails.root.join('app/assets/images/dummy.jpg')
    image_cover.attach(io: File.open(file_path), filename: 'dummy.jpg')
  end
end
