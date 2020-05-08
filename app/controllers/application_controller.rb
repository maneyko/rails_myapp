class ApplicationController < ActionController::Base

  # GET /
  def index
    render json: { message: "Hello there!! The time is #{Time.zone.now}" }
  end

  # GET /greeting/:name
  def personal_greeting
    name = params[:name]
    render json: { message: "Hello #{name}!" }
  end
end
