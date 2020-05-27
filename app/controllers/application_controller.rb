class ApplicationController < ActionController::Base
  include Concerns::RenderingHelpers

  # GET /
  def index
    log_ip(request)
    render "layouts/index"
  end

  # GET /greeting/:name
  def personal_greeting
    log_ip(request)
    name = params[:name]
    render json: { message: "Hello #{name}!" }
  end

  private def log_ip(request)
    Visit.create!(ip_address: request.remote_ip || "Not available")
  end
end
