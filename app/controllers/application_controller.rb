class ApplicationController < ActionController::API
  include Authenticatable
  before_action :authorized
end
