class Api::V1::ReplenishesController < ApplicationController

  before_action :sanitize_params

  def create
    ::Replenish.new.call(strong_params.to_h)
    head :ok
  end

  private

  def sanitize_params
    params["1"] = params["1"].to_i
    params["2"] = params["2"].to_i
    params["5"] = params["5"].to_i
    params["10"] = params["10"].to_i
    params["25"] = params["25"].to_i
    params["50"] = params["50"].to_i
  end

  def strong_params
    params.permit("1", "2", "5", "10", "25", "50")
  end

end
