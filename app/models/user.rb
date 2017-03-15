class User < ActiveRecord::Base
  has_many :time_tickets
  has_secure_password
  validates_confirmation_of :password

  validate :username_not_changed

  attr_readonly :name

  validates :name, uniqueness: true

  private
  def username_not_changed
    if name_changed? && self.persisted?
      errors.add(:name, "Change of name not allowed!")
    end
  end
end
