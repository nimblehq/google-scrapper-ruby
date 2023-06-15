# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Localization
  include Pagy::Backend

  before_action :authenticate_user!, unless: -> { is_a?(HealthCheckController) }
end
