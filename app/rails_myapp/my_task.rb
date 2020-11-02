class MyTask

  def self.create_and_run
    job = Job.where(name: self.name.underscore).first

    if job.running?
      if job.job_results.running.last.created_at < 20.minutes.ago
        job.job_results.running.each do |job_result|
          job_result.not_running!
        end
      end
    else
      return
    end

    job_result = JobResult.create!(job_id: job.id)
    self.run(job_result.id)
    job_result.id
  end

  def self.run(job_result_id)
    if self.disk_usage > 80
      Rails.logger.error "Disk usage above 80%"
      return
    end

    Thread.new do
      job_result = JobResult.find job_result_id
      job_result.running!
      result = %x{ps aux --sort -rss | awk '{n+=$4}END{print n}' && sleep 15}.chomp
      job_result.update_attribute(:result, {memory_usage_percent: result})
      job_result.not_running!
    end
  end

  def self.disk_usage
    command = %q{
      df --output=used,avail \
      | sort \
      | tail -1 \
      | perl -ne 'printf("%.1f", $1/$2 * 100) if /([\d]+)[\s]+([\d]+)/'
    }
    %x{#{command}}.to_f
  end
end
