Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'
  get 'articles', to: 'articles#getarticles'
  post 'add/article', to: 'articles#create_article'
  put 'edit/article/:id', to: 'articles#edit_article'
  delete 'delete/article/:id', to: 'articles#delete_article'
  get 'article/like/:id', to: 'articles#like_article'
  post 'article/comment/:id', to: 'articles#comment_article'
  get 'article/view/:id', to: 'articles#view_article'
  get 'myposts', to: 'articles#get_my_articles'
  get 'myprofile', to: 'users#my_profile'
  get 'follow/:id', to: 'users#follow_user'
  get 'view/user/:id', to: 'users#view_user'
end
