class Api::V1::CashOutController < ApplicationController

  before_action :sanitize_params

  def create
    payload = ::CreateCashOut.new.call(strong_params[:amount])
    render :json => payload, :status => 201
  rescue
    payload = { error: "Impossible give this amount of money" }
    render json: payload, status: :bad_request
  end

  private

  def sanitize_params
    params[:amount] = params[:amount].to_i
  end

  def strong_params
    params.permit(:amount)
  end

end
