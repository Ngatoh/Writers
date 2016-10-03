class UsersController < ApplicationController
  before_action   :logged_in_user, only: [:index, :show, :edit, :update]
  before_action   :correct_user,   only: [:show, :edit, :update]
  before_action   :admin_user,     only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
  	@user  = User.find(params[:id])
    if !current_user.admin?
      @orders = current_user.ordersfeed.paginate(page: params[:page], per_page: 15)
      @papers = current_user.papers
    end
  end


  def new
  	@user = User.new
    if logged_in? 
      if current_user.admin?
        @orders = Order.paginate(page: params[:page], per_page: 15)
        #@orders = Order.where("status = ?", "completed").paginate(page: params[:page]) TODO
      else
        @orders = current_user.feed.paginate(page: params[:page], per_page: 10)
      end
   end
  end

  def create
     @user = User.new(user_params)
    if @user.save
      log_in @user
      @user.send_welcome_email
      flash[:success] = "Your account has been created. Enjoy our services."
      redirect_to @user
    else
      render 'new'
    end  	
  end

  def edit
  end

  def update
  	@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  	User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation, :photo)
  end

# Before Filters

# Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
