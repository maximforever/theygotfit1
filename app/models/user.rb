class User < ActiveRecord::Base
  has_many :records
  has_secure_password

   validates :email, uniqueness: true
   validates :username, uniqueness: true

  def a_method_used_for_validation_purposes
    errors.add(:email, "This username already exists!")
  end

end
