class UserSession < Authlogic::Session::Base
  # Remove ASAP. The Authlogic guy should have this updated for Rails 3 soon:
  #   http://github.com/binarylogic/authlogic/issues/issue/101
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end
