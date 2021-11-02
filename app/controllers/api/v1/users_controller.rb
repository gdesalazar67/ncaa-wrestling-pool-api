class Api::V1::UsersController < ApplicationController
    before_action :find_user, only: [:show, :update, :destroy]

    def index 
        @users = User.all
        render json: @users
    end 

    def show 
        render json: @user
    end

    def create
        @user = new User(user_params)
        if @user.save
            render json: { message: 'User successfully created.' }, status: 200
        else
            render error: { message: 'Unable to create user.' }, status: 400
        end
    end

    def update
        if @user
            render json: { message: 'User successfully updated.' }, status: 200
        else 
            render json: { message: 'Unable to update user.' }, status: 400
        end
    end

    def destroy
        if @user
            @user.destroy
            render json: { message: 'User successfully deleted' }, status: 200
        else
            render json: { message: 'Unable to delete user.' }, status: 400
        end 
    end 


    private 

    def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
    end

    def find_user
        @user = User.find_by_id(params[:id])
    end
end
