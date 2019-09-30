class UsersController < ApplicationController
    before_action :set_user, only: [:update, :destroy]
    #GET /users
    def index
      render_ok User.all      
    end
    #POST /users
    def create
      user = User.new(create_params)
      # byebug
      if user.save
        render json: user,
              status: :created
              # ,
              # serializer: User::ShowSerializer
      else
        render json: user.errors.messages,
              status: :unprocessable_entity
      end
    end
    #PUT /users/{id}
    def update
      @user.attributes = update_params
      if @user.save
        render_ok @user
        # render json: @user,
        #        status: :ok,
              #  serializer: User::ShowSerializer
      else
        render json: @user.errors.messages,
               status: :unprocessable_entity
      end
    end
    #GET /users/{id}
    def show
      render_ok User.find(params[:id])
    end
    #DELETE /users/{id}
    def destroy
    
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def create_params
      params.require(:user).permit(
        :role,
        :email,
        :password,
        :name,
        :first_lastname,
        :second_lastname,
      )
    end
  
    def update_params
      params.require(:user).permit(
        :role,
        :email,
        :password,
        :name,
        :first_lastname,
        :second_lastname
      )
    end
end