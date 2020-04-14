class User < ApplicationRecord
  validates :email, :address, :first_name, presence: true, length: { minimum: 6, maximum: 254 }
  validates :last_name, length: { maximum: 254 }, if: :last_name
  validates :phone_number, format: { with: P_NUMBER_REGEXP }, length: { maximum: 254 }, if: :phone_number
  validates :email, format: { with: EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
end
