class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in, except: %i[ index main login new create signup register]
  before_action :is_user, only: %i[ show edit update destroy ]
  before_action :is_nuser, only: %i[ feed ]
  @fLogin = false
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    temp = user_params["email"] 
    tempU = User.find_by(email:temp)
    if tempU != nil
      redirect_to main_path,alert: "Can't use this email"
    else
        respond_to do |format|
          if @user.save
            format.html { redirect_to main_path, notice: "User was successfully created." }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    end  
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to "/feed/#{@user.id}", notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def main
    session[:user_id] = nil
    if @fLogin
      @user = User.find_by(email: @email)
    else
      @user = User.new
    end
  end

  def login
    luser = params[:user]
    @email = luser['email']
    @password = luser['password']
    @user = User.find_by(email: @email)
    respond_to do |format|
      if @user != nil 
        if @user.authenticate(@password.to_s)
          session[:user_id] = @user.id
          format.html { redirect_to "/feed/#{@user.id}", notice: "User was successfully updated." }
          format.json { render :showUser, status: :ok, location: @user }
        else 
          @fLogin = true
          format.html { redirect_to main_path, alert: "Wrong password"}
          format.json { render json: @user.errors, status: :unprocessable_entity}
        end
      else
        @fLogin = true
        @user = User.new
        format.html { redirect_to main_path ,alert: "Not found this user"}
        format.json { render json: @user.errors, status: :unprocessable_entity}
      end
    end

    def feed
      id = params[:id]
      @user = User.find_by(id: id)
      @pfeed = @user.get_feed_post
    end

    def profile
    end

    
  end

  private
    def logged_in
      if(session[:user_id])
        return true
      else
        redirect_to main_path, alert: "Please login."
      end
    end

    def is_user
      if(session[:user_id] != @user.id)
        redirect_to main_path, alert: "Log in with wrong user"
      else
        return true
      end
    end

    def is_nuser
      if(session[:user_id].to_s != params[:id])
        redirect_to main_path, alert: "Log in with wrong user"
      else
        return true
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
