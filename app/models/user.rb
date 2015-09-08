class User < ActiveRecord::Base
  has_many :records
  has_secure_password

   validates :email, uniqueness: true
   validates :username, uniqueness: true

end
