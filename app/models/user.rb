class User < ApplicationRecord
  validates :email, :address, :first_name, :phone_number, presence: true, length: { minimum: 5, maximum: 254 }
  validates :last_name, length: { maximum: 254 }, if: :last_name
  validates :phone_number, format: { with: P_NUMBER_REGEXP }
  validates :email, format: { with: EMAIL_REGEXP }, uniqueness: { case_sensitive: false }

  has_secure_password
end
