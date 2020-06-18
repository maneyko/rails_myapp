class JobResult < ActiveRecord::Base
  belongs_to :job
  enum status: %i[not_running running]
end
