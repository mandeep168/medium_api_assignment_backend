class UsersController < ApplicationController
    before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index my_profile show_profile view_user follow_user]

  # GET /myprofile
  def show_profile (userToShow)
    ActiveStorage::Current.host = "http://localhost:3000"
    profile = {
      "name": userToShow.profile.name, 
      "avatar": userToShow.profile.avatar.url,
      "bio": userToShow.profile.bio,
      "email": userToShow.email,
      "followers": userToShow.followers,
      "following": userToShow.following,
      "joined_on": userToShow.created_at.strftime('%d/%m/%Y')
    }
  end

  def my_profile
    render json: show_profile(@current_user)
  end

  def view_user
    render json: show_profile(User.find_by(params[:id]))
  end

  def follow_user
    follow = Follow.where(follower_id: @current_user.id, following_id: params[:id])
    if follow.length == 0
      follow = Follow.new();
      follow.follower_id = @current_user.id;
      follow.following_id = params[:id]
      follow.save
      response = {
        message: "User followed successfully",
        data: follow
      }
    else 
      follow.first.destroy
      response = {
        message: "User unfollowed successfully"
      }
    end
    render json: response
  end


  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
        @profile = Profile.new(profile_params)
        @profile.avatar.attach(params[:avatar]) if params[:avatar].present?
        @profile.user_id = @user.id
        @profile.save
        
        ActiveStorage::Current.host = "http://localhost:3000"
        puts @profile.avatar.url
      render json: @profile, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_email!(params[:email])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
        :email, :password, :password_confirmation
    )
  end

  def profile_params
    params.permit(
        :name, :bio
    )
  end
end
