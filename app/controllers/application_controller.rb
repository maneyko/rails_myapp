class ApplicationController < ActionController::Base

  # GET /
  def greeting
    render json: { message: "Hiii there!!" }
  end

  # GET /greeting/:name
  def personal_greeting
    name = params.fetch(:name, "Peter")
    render json: { message: "Hello #{name}!" }
  end
end
