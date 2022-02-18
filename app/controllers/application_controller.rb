class ApplicationController < ActionController::API
  include Authenticatable
  include Pundit::Authorization
  before_action :authorized
  before_action do
    ActiveStorage::Current.host = request.base_url
  end
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    @current_user
  end

  private

  def user_not_authorized
    render json: { message: 'You are not authorized to perform this action.' }, status: :forbidden
  end
end
