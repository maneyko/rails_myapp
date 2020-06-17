class MyTask
  def self.run(script_runner_job_id)
    Thread.new do
      script_runner_job = ScriptRunnerJob.find script_runner_job_id
      script_runner_job.running!
      result = %x{ps aux --sort -rss | awk '{n+=$4}END{print n}' && sleep 15}.chomp
      script_runner_job.update_attribute(:result, result)
      script_runner_job.not_running!
    end
  end
end
