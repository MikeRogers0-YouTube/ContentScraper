Rails.application.routes.draw do
  namespace :v1, path: '1.0' do
    resources :page_contents, only: [:index, :show], param: :url
  end
end
