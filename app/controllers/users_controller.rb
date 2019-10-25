class UsersController < ApplicationController
    
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :set_users, only: [:index]
    skip_before_action :get_current_user, only: [:create]
    
    def index
      render_ok @users
    end

    def create
      user = User.new(user_params)
      save_and_render user
    end

    def update
      @user.attributes = user_params
      save_and_render @user
    end

    def show
      render_ok @user
    end

    def destroy
      render_ok @user.destroy
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def set_users
      @users = params[:user_type]  == 'teacher' ? User.teachers : User.students
      @users = @users.paginate(page: params[:page], per_page: params[:per_page]) if params[:page] and params[:per_page]
    end

    def user_params
      params.require(:user).permit(
        :role,
        :email,
        :password,
        :names,
        :first_lastname,
        :second_lastname,
      )
    end
end