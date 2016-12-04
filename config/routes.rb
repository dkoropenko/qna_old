Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'
  put 'answers/:id/choose_best_answer',
      controller: 'answers',
      action: 'choose_best_answer',
      as: 'choose_best_answer'

  resources :questions do
    resources :answers, shallow: true
  end
end
