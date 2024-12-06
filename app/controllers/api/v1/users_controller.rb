module Api::V1
  class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def create
      user = User.new(user_params)
      user.save!
      render json: UserSerializer.new(user).serializable_hash, status: :created
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name)
    end
  end
end
