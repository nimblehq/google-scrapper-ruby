class HealthCheckController < ApplicationController
  def health_check
    render status: :ok, json: { message: 'OK' }
  end
end
