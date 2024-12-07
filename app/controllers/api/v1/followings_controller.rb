module Api::V1
  class FollowingsController < Api::V1::ApplicationController
    def follow
      result = FollowingServices::Follow.call(current_user: current_user, params: follow_params)

      if result.is_a?(FollowingServices::Follow::Error)
        render json: { error: result.message }, status: :bad_request
      else
        render json: FollowingSerializer.new(result).serializable_hash
      end
    end

    def unfollow
      result = FollowingServices::Unfollow.call(current_user: current_user, params: follow_params)

      if result.is_a?(FollowingServices::Unfollow::Error)
        render json: { error: result.message }, status: :bad_request
      else
        render json: FollowingSerializer.new(result).serializable_hash
      end
    end

    private

    def follow_params
      params.permit(:following_user_id)
    end
  end
end