class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  has_many :categories
  has_many :facts, :through => :categories

  validates_format_of :login, :with => /^[a-z][a-z0-9\-_.]+$/
  validates_length_of :login, :in => 4..24
  validates_presence_of :login
  validates_uniqueness_of :login

  def to_json
    json = { :user => {
      :id => id, :last_login_at => last_login_at, :login => login, :login_count => login_count
    } }
    json
  end

  def to_param
    login
  end
end
