Rails.application.routes.draw do
  root to: 'questions#index'
  
  devise_for :users

  put 'answers/:id/choose_best_answer',
      controller: 'answers',
      action: 'choose_best_answer',
      as: 'choose_best_answer'

  delete '/attachments/:id', 
  	  controller: 'attachments',
  	  action: 'destroy',
  	  as: 'destroy_attachment'

  resources :questions do
    resources :answers, shallow: true
  end
end
