module Api::V1
  class UsersController < Api::V1::ApplicationController
    include ActionController::RequestForgeryProtection

    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
  
    def create
      user = User.new(user_params)
      user.save!
      render json: UserSerializer.new(user).serializable_hash, status: :created
    end
  
    private
  
    def user_params
      params.permit(:name)
    end
  end
end
