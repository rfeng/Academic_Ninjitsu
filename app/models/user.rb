require digest

class User < ActiveRecord::Base

	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation

	validates_presence_of :name, :email, :password

	validates_length_of :name, :maximum => 50

	EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]@\.[a-z]+\z/i
		validates_format_of :email, :with => EmailRegex
	validates_uniqueness_of :email, :cse_sensitive => false

	validates_confirmation_of :password
	validates_length_of :password, :within => 6..40

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypt(submitted_password) == encrypted_password
	end

	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
		
	private
		def encrypt_password
			self.salt = make_salt
			self.encrypted_password = encrypt(password)
		end
		def encrypt(string)
			secure_hash("#{salt}#{string}")
		end
		def make_salt
			secure_hash("#{Time.now.utc}#{password}")
		end
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
