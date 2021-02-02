class UserController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update, :destroy]

    ## This isn't necessary right? Because there is only one user?
    # def index
    # end
    
    def show
        find_user
    end

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
          flash[:success] = "User successfully created"
          redirect_to @user
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    def edit
        find_user
    end

    def update
        if @user.update(user_params)
          flash[:success] = "User was successfully updated"
          redirect_to @user
        else
          flash[:error] = "Something went wrong"
          render 'edit'
        end
    end

    def destroy
        if @user.destroy
            flash[:success] = 'User was successfully deleted.'
            redirect_to users_path
        else
            flash[:error] = 'Something went wrong'
            redirect_to users_path
        end
    end
    
    private

    def find_user
        @user = User.find(params[:id])
    end
    
    def user_params
        params.require(:user).permit(:name, :description, :credit_limit, :balance, :account_number)
    end
end