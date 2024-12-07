module FollowingServices
  # Unfollow user only if the user is already following
  class Unfollow < ApplicationService
    Error = Class.new(StandardError)

    def initialize(current_user:, params:)
      @current_user = current_user
      @params = params
    end

    def call
      return Error.new("You can't unfollow your self") if @current_user.id == @params[:following_user_id].to_i
      return Error.new('User not found') if following_user.blank?

      following = @current_user.follower.find_by(following_user_id: following_user.id)
      return Error.new("You are not following #{following_user.name}") if following.blank?

      following.destroy
    end

    private

    def following_user
      User.find_by(id: @params[:following_user_id])
    end
  end
end