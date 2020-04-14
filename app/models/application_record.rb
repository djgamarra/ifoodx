class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  P_NUMBER_REGEXP = /\A\+?[0-9]+\z/.freeze
  EMAIL_REGEXP    = URI::MailTo::EMAIL_REGEXP.freeze

  scope :paginate, -> (limit, page) { self.limit(limit).offset((page - 1) * limit) }

  def err
    self.errors.messages
  end
end
