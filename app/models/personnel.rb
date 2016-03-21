class Personnel < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password, :except => :send_password_reset 
   before_update :encrypt_password, :except => :send_password_reset 
  
  validates :password, :format => {:with => /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/, message: "must be at least 6 characters and include one number and one letter"}
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create 
  validates_presence_of :email

  validates_uniqueness_of :email
  validates_uniqueness_of :name
  before_create { generate_token(:auth_token) }
  	
def send_password_reset
  generate_token(:password_reset_token)
   self.password_reset_sent_at = Time.zone.now
  save!(:validate => false)
  UserMailer.password_reset(self).deliver
end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Personnel.exists?(column => self[column])
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user
    else
      user = find_by_name(email)
    end
    if user && user.passwordhash == BCrypt::Engine.hash_secret(password, user.passwordsalt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.passwordsalt = BCrypt::Engine.generate_salt
      self.passwordhash = BCrypt::Engine.hash_secret(password, passwordsalt)
    end
  end
  
end
