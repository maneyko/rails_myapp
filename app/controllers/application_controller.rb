class ApplicationController < ActionController::Base
  include Concerns::RenderingHelpers

  # GET /
  def index
    log_ip(request)
    render "layouts/index"
  end

  # GET /echo
  def echo
    render json: { data: params.except(:action, :controller).as_json.merge(timestamp: Time.zone.now.iso8601), status: "success" }
  end

  # GET /greeting/:name
  def personal_greeting
    log_ip(request)
    name = params[:name]
    render json: { data: "Hello #{name}!" }
  end

  private def log_ip(request)
    Visit.create!(ip_address: request.remote_ip || "Not available")
  end
end
