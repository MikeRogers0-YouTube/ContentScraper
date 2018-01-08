Rails.application.routes.draw do
  namespace :v1, path: '1.0' do
    resources :page_contents, only: [:index] do
      collection do
        get :lookup, to: :lookup
      end
    end
  end
end
