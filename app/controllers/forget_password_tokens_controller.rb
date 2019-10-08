class ForgetPasswordTokensController < ApplicationController
  skip_before_action :get_current_user 
  
  before_action :set_user_by_email, only: [:create]
  before_action :set_user_by_token, only: [:show, :destroy]
  after_action :send_url_by_email, only: [:create]

  def create
    @url = params[:url]
    @fp_token = ForgetPasswordToken.new(user_id: @user.id)
    save_and_render @fp_token
  end

  def show
    render_ok @fp_token
  end

  def destroy
    @user.password = params[:password]
    @user.save
    render_ok @fp_token.destroy
  end

  private
  def set_user_by_email
    @email = params[:email]
    @user = User.find_by email: @email
    error_message = "No existe un usuario con email #{@email}"
    raise ActiveRecord::RecordNotFound.new(error_message) unless @user
  end

  def set_user_by_token
    @fp_token = ForgetPasswordToken.find_by secret: params[:token]
    if @fp_token
      @user = @fp_token.user
    else
      error_message = "Ningun usuario esta relacionado con el token #{params[:token]}"
      raise ActiveRecord::RecordNotFound.new(error_message)
    end
  end

  def send_url_by_email
    EmailNotifierWorker.perform_in(5.seconds, 'ForgetPasswordMailer', @user.id, @url, @fp_token.secret)
  end
end
