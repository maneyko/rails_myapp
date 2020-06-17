class ScriptRunnerController < ActionController::Base
  # GET /script_runner_names
  def index
    render json: {status: "success", data: ScriptRunnerNames.all}
  end

  # GET /script_runner_name/:id/run
  def run
    begin
      script_runner_name = ScriptRunnerName.find params[:id]
    rescue ActiveRecord::RecordNotFound
      return render json: {status: "failure", data: {message: "Could not find script_runner_name with id #{params[:id]}"}}
    end

    if script_runner.running?
      return render json: {status: "failure", data: {message: "The script is currently running"}}
    else
      script_runner.name.camelize.constantize.run
    end
  end

  # GET /script_runners/:id/status
  def status
    begin
      script_runner = ScriptRunner.find params[:id]
    rescue ActiveRecord::RecordNotFound
      return render json: {status: "failure", data: {message: "Could not find script_runner with id #{params[:id]}"}}
    end
    return render json: {status: "success", data: {status: script_runner.status}}
  end
end
