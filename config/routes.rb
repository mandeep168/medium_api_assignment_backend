Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post :orders, to: 'orders#create'
    end
  end
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  post 'add/article', to: 'articles#create_article'
  put 'edit/article/:id', to: 'articles#edit_article'
  delete 'delete/article/:id', to: 'articles#delete_article'
  get 'article/like/:id', to: 'articles#like_article'
  post 'article/comment/:id', to: 'articles#comment_article'
  get 'article/view/:id', to: 'articles#add_view_to_article'
  get 'myprofile', to: 'users#my_profile'
  get 'profile/:id', to: 'users#view_user'
  get 'follow/:id', to: 'users#follow_user'
  get 'view/user/:id', to: 'users#view_user'

  
  get 'articles', to: 'getarticles#getarticles'
  get 'myposts', to: 'getarticles#get_my_articles'
  get 'filter/author/:id', to: 'getarticles#filter_by_user'
  get 'filter/date/:start_date/:end_date', to: 'getarticles#filter_by_date'
  post 'search', to: 'getarticles#search'
  get 'sort/likes', to: 'getarticles#sort_by_likes_count'
  get 'sort/comments', to: 'getarticles#sort_by_comments_count'
  
  post 'create/list/', to: 'list#create_list'
  get 'list/add/:article_id/:list_id', to: 'list#add_article_to_list'
  get 'list/view', to: 'list#view_all_lists'
  get 'list/view/:id', to: 'list#view_list'


  get 'saveforlater/:id', to: 'save_for_later#mark_and_unmark'
  get 'saveforlater', to: 'save_for_later#view'

  get 'topics/view', to: 'topic#view_topics'

  post 'save/draft', to: 'drafts#save_or_update_draft'
  get 'draft', to: 'drafts#get_draft'
end
