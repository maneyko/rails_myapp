class ScriptRunner < ActiveRecord::Base
  has_many :script_runner_jobs

  scope :running, ->(*task_name) {
    where(name: task_name).
    joins(:script_runner_jobs).
    merge(ScriptRunnerJob.running)
  }

  def running?
    !self.class.running(self.name).empty?
  end
end
