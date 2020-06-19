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
    unless self.disk_usage > 80
      Thread.new do
        job_result = JobResult.find job_result_id
        job_result.running!
        result = %x{ps aux --sort -rss | awk '{n+=$4}END{print n}' && sleep 15}.chomp
        job_result.update_attribute(:result, {memory_usage_percent: result})
        job_result.not_running!
      end
    else
      Rails.logger.error "Disk usage above 80%"
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
