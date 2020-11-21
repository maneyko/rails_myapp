Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "application#index"
  get "/greeting/:name", to: "application#personal_greeting"
  get "/echo",           to: "application#echo"

  get "/jobs",                   to: "job#index"
  get "/jobs/:id/run",           to: "job#run"
  get "/job_results",            to: "job#latest_jobs"
  get "/job_results/:start",     to: "job#latest_jobs_by_5"
  get "/job_results/:id/status", to: "job#status"
  get "/job_results/:id/result", to: "job#result"
end
