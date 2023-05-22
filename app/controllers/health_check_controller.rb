# frozen_string_literal: true

class HealthCheckController < ApplicationController
  def health_check
    render status: :ok, json: { message: 'OK' }
  end
end
