class User < ActiveRecord::Base
  has_many :records
  has_secure_password

  before_create :confirmation_token
  before_create { generate_token(:auth_token) }


  validates :email, presence: true, uniqueness: { message: "is already in use" }
  validates :username, presence: true, uniqueness: { message: " is already in use" }
  validates :password, presence: true, on: :create
  validates :age, presence: true
  validates :zipcode, presence: true
  validates :name, presence: true


  def to_param
    username
  end

  def has_records?
   return true if User.find_by_id(id).records.size > 0 
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(:validate => false)
    UserMailer.password_reset(self).deliver
  end

  def has_about
    puts "Testing HAS_ABOUT"

    if (!bio_eat.nil? || !bio_do.nil? || !bio_about.nil?) 
      puts "something is not nil"
      if(!bio_eat.empty? || !bio_do.empty? || !bio_about.empty?)     
        puts "something is not empty"
        return true 
      else
        puts "something is not nil, but everything is empty"
        puts "returning false"
        return false
      end
    else
      puts "returning false"
      return false
    end
  end

  private 

  def confirmation_token
    if self.confirm_token.blank?
        self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
