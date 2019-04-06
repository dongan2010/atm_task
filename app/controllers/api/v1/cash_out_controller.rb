class Api::V1::CashOutController < ApplicationController

  before_action :sanitize_params

  def create
    ::CreateCashOut.new.call(strong_params[:amount])
  end

  private

  def sanitize_params
    params[:amount] = params[:amount].to_i
  end

  def strong_params
    params.permit(:amount)
  end

end
