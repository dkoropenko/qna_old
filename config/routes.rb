Rails.application.routes.draw do
  root to: 'questions#index'
  
  devise_for :users

  put 'answers/:id/choose_best_answer',
      controller: 'answers',
      action: 'choose_best_answer',
      as: 'choose_best_answer'

  resources :questions do
    resources :answers, shallow: true
  end
end
