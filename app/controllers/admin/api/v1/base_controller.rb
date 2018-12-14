class Admin::Api::V1::BaseController < ActionController::API
  before_action :require_admin!

  def four_oh_four
    raise ActionController::RoutingError.new('Not Found')
  end
end
