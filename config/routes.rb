Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "application#index"
  get "/greeting/:name", to: "application#personal_greeting"

  get "/script_runners",                to: "script_runner#index"
  get "/script_runners/:id/run",        to: "script_runner#run"
  get "/script_runner_jobs/:id/status", to: "script_runner#status"
  get "/script_runner_jobs/:id/result", to: "script_runner#result"
end
