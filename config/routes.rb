Rails.application.routes.draw do
  root 'polls#index'

  get '/create', controller: 'polls', action: 'create'
  post '/save', controller: 'polls', action: 'save'
  get '/:id', controller: 'polls', action: 'show'
  get '/:id/edit', to: 'polls#edit'
  get '/:id/delete', to: 'polls#remove'
  get '/:poll/:option/vote', to: 'polls#vote'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
