module FollowingServices
  # Follow user only if the user is not already following
  class Follow < ApplicationService
    Error = Class.new(StandardError)

    def initialize(current_user:, params:)
      @current_user = current_user
      @params = params
    end

    def call
      return Error.new("You can't follow your self") if @current_user.id == @params[:following_user_id]
      return Error.new('Following user not found') if following_user.blank?
      
      following = @current_user.follower.find_by(following_user_id: following_user.id)
      return Error.new("You are already follow #{following_user.name}") if following.present?

      @current_user.follower.create(following_user_id:following_user.id)
    end

    private

    def following_user
      User.find_by(id: @params[:following_user_id])
    end
  end
end