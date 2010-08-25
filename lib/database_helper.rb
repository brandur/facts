module DatabaseHelper
  def db_random
    if sqlite?
      'RANDOM()'
    else
      'RAND()'
    end
  end

  def sqlite?
    ActiveRecord::Base.connection.class.name.downcase.include? 'sqlite'
  end
end

