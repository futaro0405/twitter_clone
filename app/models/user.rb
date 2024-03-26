# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :recoverable, :registerable,
         :rememberable, :trackable, :timeoutable, :validatable, :Lockable, :omniauthable, omniauth_providers: %i[github]

  with_options presence: true do
    validates :name
    validates :telephone
    validates :birth_date
  end

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.telephone_number = '00000000000'
      user.date_of_birth = '1997-01-01'

      if user.persisted? || auth.provider == 'github'
        user.skip_confirmation! if auth.provider == 'github'
        user.save
      end
    end
  end
end
