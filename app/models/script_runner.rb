class ScriptRunner < ActiveRecord::Base
  has_many :script_runner_results
  belongs_to :script_runner_name
  enum status: %i[not_running running]
end
