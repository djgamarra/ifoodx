class Membership < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :member_type, presence: true
end
