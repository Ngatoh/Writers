class User < ActiveRecord::Base
	attr_accessor :remember_token, :reset_token
	before_save   :downcase_email
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
 	validates :email, presence: true, length: { maximum: 255 },
      		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }

  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  #Realationships
  has_many :purchases,        dependent: :destroy
  has_many :orders,           dependent: :destroy
  has_many :usermaterials,    dependent: :destroy
  has_many :papers,           through: :purchases
  has_many :messges,          dependent: :destroy

  mount_uploader  :photo, UserpicUploader
 
 # Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end
# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end
# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end


 # Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

# Sets the password reset attributes.
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end
# Sends password reset email.
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

# Sends Welcome email.
	def send_welcome_email
		UserMailer.welcome(self).deliver_now
	end
# Returns true if a password reset has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

#FEEDS

# Gets orders of the current user
def feed
	Order.where("user_id = ? && answered = ?", id, false)
end

def ordersfeed
	Order.where("user_id = ? && answered = ?", id, true)
end

def papersfeed
	purchases = Purchase.where("user_id = ? && status = ?", id, "completed")
	purchases.each { |purchase|
		paper = Paper.where("id = ?", purchase.paper_id)
		if paper?
			papers<<paper
			return papers
		end
	}
end



private 
#Converts email to lowercase
  def downcase_email
    self.email = email.downcase
  end

end
