class ScriptRunnerController < ActionController::Base

  # GET /script_runners
  def index
    render json: {status: "success", data: ScriptRunner.all}
  end

  # GET /script_runners/:id/run
  def run
    script_runner = find_id(ScriptRunner, params[:id]) or return render_error(ScriptRunner)
    if script_runner.running?
      render json: {status: "failure", data: {
        message: "Already running",
        job_id:  script_runner.script_runner_jobs.running.first.id
      }}
    else
      script_runner_job = ScriptRunnerJob.create!(script_runner_id: script_runner.id)
      script_runner.name.camelize.constantize.run(script_runner_job.id)
      render json: {status: "success", data: {
        message: "Running job",
        job_id:  script_runner_job.id
      }}
    end
  end

  # GET /script_runner_jobs/:id/status
  def status
    script_runner_job = find_id(ScriptRunnerJob, params[:id]) or return render_error(ScriptRunnerJob)
    render json: {status: "success", data: {status: script_runner_job.status}}
  end

  # GET /script_runner_jobs/:id/result
  def result
    script_runner_job = find_id(ScriptRunnerJob, params[:id]) or return render_error(ScriptRunnerJob)
    if script_runner_job.running?
      render json: {status: "failure", data: {
        message: "Script is still running",
        job_id:  script_runner_job.id
      }}
    else
      render json: {status: "success", data: {result: script_runner_job.result}}
    end
  end

  # GET /script_runner_jobs
  def latest_jobs
    render json: {status: "success", data: ScriptRunnerJob.last(5)}
  end

  def find_id(klass, id)
    begin
      klass.find id
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def render_error(klass)
    render json: {status: "failure", data: {message: "Could not find #{klass.name} with id #{params[:id]}"}}
  end
end
