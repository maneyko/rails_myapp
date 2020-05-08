class ApplicationController < ActionController::Base

  # GET /
  def greeting
    render json: { message: "Hiii there!! The time is #{Time.zone.now}" }
  end

  # GET /greeting/:name
  def personal_greeting
    name = params.fetch(:name, "Peter")
    render json: { message: "Hello #{name}!" }
  end
end
