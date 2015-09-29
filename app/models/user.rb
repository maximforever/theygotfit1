class User < ActiveRecord::Base
  has_many :records
  has_secure_password


   validates :email, presence: true, uniqueness: { message: "is already in use" }
   validates :username, presence: true, uniqueness: { message: " is already in use" }
   validates :age, presence: true
   validates :zipcode, presence: true
   validates :name, presence: true
  

   def has_records?
    return true if User.find_by_id(id).records.size > 0 
   end

end
