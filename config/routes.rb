Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :complete  # Custom route for marking a task as complete
    end
  end
  root "tasks#index"  # Set the root route to the tasks index
end
