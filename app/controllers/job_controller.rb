class JobController < ActionController::Base

  # GET /jobs
  def index
    render json: {status: "success", data: Job.all}
  end

  # GET /jobs/:id/run
  def run
    job = find_id(Job, params[:id]) or return render_error(Job)
    if job.running?
      render json: {status: "failure", data: {
        message: "Already running",
        job_id:  job.job_results.running.first.id
      }}
    else
      job_result = JobResult.create!(job_id: job.id)
      job.name.camelize.constantize.run(job_result.id)
      render json: {status: "success", data: {
        message: "Running job",
        job_id:  job_result.id
      }}
    end
  end

  # GET /job_results/:id/status
  def status
    job_result = find_id(JobResult, params[:id]) or return render_error(JobResult)
    render json: {status: "success", data: {status: job_result.status}}
  end

  # GET /job_results/:id/result
  def result
    job_result = find_id(JobResult, params[:id]) or return render_error(JobResult)
    if job_result.running?
      render json: {status: "failure", data: {
        message: "Job is still running",
        job_id:  job_result.id
      }}
    else
      render json: {status: "success", data: {result: job_result.result}}
    end
  end

  # GET /job_results
  def latest_jobs
    render json: {status: "success", data: JobResult.last(5)}
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
