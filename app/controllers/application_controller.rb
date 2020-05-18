class ApplicationController < ActionController::Base

  # GET /
  def index
    render "layouts/index"
  end

  # GET /greeting/:name
  def personal_greeting
    name = params[:name]
    render json: { message: "Hello #{name}!" }
  end
end
