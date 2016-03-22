class Invitation < ActiveRecord::Base
  before_save :generate_token

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :mail, presence: true, format: { with: email_regex }

  def encrypt(string)
    secure_hash("chikdanslemuso-#{string}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def generate_token
    self.token = self.encrypt("#{self.id}-#{Time.now.nsec}").concat(Time.now.nsec.to_s)
  end

end
