class Job < ActiveRecord::Base
  has_many :job_results

  scope :running, ->(*task_name) {
    where(name: task_name).
    joins(:job_results).
    merge(JobResult.running)
  }

  def running?
    !self.class.running(self.name).empty?
  end
end
