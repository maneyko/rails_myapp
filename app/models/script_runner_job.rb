class ScriptRunnerJob < ActiveRecord::Base
  belongs_to :script_runner
  enum status: %i[not_running running]
end
