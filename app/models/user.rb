class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  has_many :categories
  has_many :facts, :through => :categories

  validates_format_of :login, :with => /^[a-z][a-z0-9\-_.]+$/
  validates_length_of :login, :in => 4..24
  validates_presence_of :login
end
