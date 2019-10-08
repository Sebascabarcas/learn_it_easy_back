module SecretGenerator
  extend ActiveSupport::Concern

  #Inputs secret generator 
  EXPIRATION_TIME = {period: :day, unit: 7}

  private
  #This method generate uniqueness secret token string
  def generate_secret_token
    begin
      self.secret = SecureRandom.uuid.gsub(/-/, '')
    end while (model.where(secret: self.secret).any?)
    self.secret
  end
  
  # This method set expiration time of token_secret
  def set_expire_at_secret
    unit = EXPIRATION_TIME[:unit]
    time = 
      case EXPIRATION_TIME[:period]
      when :minute then unit.minute
      when :day then unit.day
      when :week then unit.week
      when :year then unit.year
      else
        1.day
      end
    self.expire_at ||= time.from_now  
  end

  def model
    self.class
  end
end
