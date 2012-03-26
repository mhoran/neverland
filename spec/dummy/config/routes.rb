Dummy::Application.routes.draw do
  root :to => 'test#index'
  match '/decapitated' => 'decapitated#index'
end
