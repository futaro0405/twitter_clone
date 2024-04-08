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
  has_one_attached :image_avatar do |attachable|
    attachable.variant :icon, resize_to_limit: [150, 150]
    attachable.variant :profile, resize_to_limit: [300, 300]
  end
  has_one_attached :image_cover
  has_many :posts, dependent: :destroy

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.telephone = '00000000000'
      user.birth_date = '1990-01-01'

      if user.persisted? || auth.provider == 'github'
        user.skip_confirmation! if auth.provider == 'github'
        user.save
      end
    end
  end

  private

  def set_image_avatar
    if !self.image_avatar.attached?
      file_path = Rails.root.join('app/assets/images/dummy.jpg')
      self.image_avatar.attach(io: File.open(file_path), filename: 'dummy.jpg')
    end
  end

  def set_image_cover
    if !self.image_cover.attached?
      file_path = Rails.root.join('app/assets/images/dummy.jpg')
      self.image_cover.attach(io: File.open(file_path), filename: 'dummy.jpg')
    end
  end
end
