class User < ActiveRecord::Base
  before_save :encrypt_password
  # before_save :generateToken, if: :new_record?
  after_initialize :default_values

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :login, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :tel, presence: true
  validates :promo, presence: true
  validates :mail, presence: true, uniqueness: true, format: { with: email_regex }
  validates :password, presence: { if: :new_record? }

  def default_values
    self.admin ||= false
    self.actif ||= true
  end

  #SignUp
  def encrypt_password
    if self.changed.include?('password') && !password.blank?
      self.password = encrypt(password)
    else
      self.password = User.find(self.id).password
    end
  end

  def encrypt(string)
    secure_hash("nietnietniet-#{string}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  #SignIn
  def self.auth(login, password)
    user = User.find_by_login(login)
    return nil if user.nil?
    return nil if user.password != user.encrypt(password)
    # user.generateToken
    user.save
    return user
  end

  # def generateToken
  #   self.apiToken = self.encrypt("#{self.password}-#{self.id}-#{Time.now.nsec}").concat(Time.now.nsec.to_s)
  # end

end
