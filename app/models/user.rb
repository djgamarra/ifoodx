class User < ApplicationRecord
  validates :email, :address, :first_name, :phone_number, presence: true, length: { minimum: 4, maximum: 254 }
  validates :last_name, length: { maximum: 254 }, if: :last_name
  validates :phone_number, format: { with: P_NUMBER_REGEXP }
  validates :email, format: { with: EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, maximum: 254 }, if: :password

  has_one :membership, dependent: :destroy

  after_create :create_membership_custom
  has_secure_password

  private

  def create_membership_custom
    unless self.create_membership member_type: 'normal'
      errors.add :membership, 'No se pudo validar la información de pago'
      raise ActiveRecord::Rollback
    end
  end
end
