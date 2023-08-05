class UsersController < ApplicationController
    before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index, my_profile]

  # GET /myprofile
  def my_profile
    profile = {
      "email": @current_user.email,
      "joined_on": @current_user.created_at.strftime('%d/%m/%Y'),
      "name": @current_user.profile.name,
      "bio": @current_user.profile.bio
    }
    render json: profile
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
        puts @user.id
        @profile.user_id = @user.id
        @profile.save
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
