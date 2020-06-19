class MyTask

  def self.create_and_run
    job = Job.where(name: self.name.underscore).first
    unless job.running?
      job_result = JobResult.create!(job_id: job.id)
      self.run(job_result.id)
      job_result.id
    end
  end

  def self.run(job_result_id)
    Thread.new do
      job_result = JobResult.find job_result_id
      job_result.running!
      result = %x{ps aux --sort -rss | awk '{n+=$4}END{print n}' && sleep 15}.chomp
      job_result.update_attribute(:result, {memory_usage_percent: result})
      job_result.not_running!
    end
  end
end
