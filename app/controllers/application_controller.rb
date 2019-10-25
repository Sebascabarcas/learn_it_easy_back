class ApplicationController < ActionController::API

  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Exceptions::CurrentUserNotFound, with: :if_user_not_found
  rescue_from Exceptions::TokenExpired, with: :if_token_expired
  rescue_from Exceptions::PasswordTokenExpired, with: :if_password_token_expired
  rescue_from Exceptions::EmailVerificationTokenExpired, with: :if_email_verification_token_expired
  rescue_from Exceptions::NoCurrentStage, with: :no_current_stage_error

  before_action :get_current_user

  protected

  def get_current_user
    set_user_by_token
    raise Exceptions::CurrentUserNotFound unless @current_user
  end
  
  def set_user_by_token
    @current_user = nil
    authenticate_with_http_token do |key, options|
      @token = Token.find_by(secret: key)
      expired = @token ? @token.expire_at.past? : false
      if expired
        @token.destroy
        raise Exceptions::TokenExpired
      end
      @current_user = @token.user if @token
      #Raise exceptions if the user is not verified!
      if @current_user.email_verification_status == "not_verified"
        raise Exceptions::EmailVerificationTokenExpired
      end
    end
  end

  #This method is general an is used by other methods.
  #This method depends on a variable setted previously named @current_stage
  #This method returns a boolean instead of raising an exception because
  #I don't know how to pass a number to it. I should google it!

  def permissions_error
    render json: { authorization: 'you dont have permissions!' },
           status: :permissions_error
  end

  def render_ok(obj)
    render json: obj, status: :ok
  end

  def if_save_succeeds(obj, options = {})
    if obj.save
      self.send(options[:call_after_save]) if options[:call_after_save]
      yield(obj) if block_given?
    else
      self.send(options[:call_if_error]) if options[:call_if_error]
      render json: { errors: obj.errors.messages },
             status: options[:error_status] || :unprocessable_entity
    end
  end

  def save_and_render(obj, options = {})
    if_save_succeeds(obj, options) do |object|
      render json:
               if options[:call_on_render]
                 self.send(options[:call_on_render])
               else
                 object
               end,
             status: options[:succeed_status] || :ok
      self.send(options[:call_after_render]) if options[:call_after_render]
    end
  end

  def record_not_found(exception)
    render json: { record_not_found: exception.message },
           status: :unprocessable_entity
  end

  def if_user_not_found
    render json: { authentication: 'user not found' },
           status: :unprocessable_entity
  end

  def if_token_expired
    render json: { authentication: 'token has expired' },
           status: :unprocessable_entity
  end

  def if_password_token_expired
    render json: { authentication: 'password token has expired' },
           status: :unprocessable_entity
  end

  def if_email_verification_token_expired
    render json: { authentication: 'email verification token has expired' },
           status: :unprocessable_entity
  end

  def no_current_stage_error
    render json: { stage_not_found: 'There is no current stage' },
           status: :unprocessable_entity
  end
end
