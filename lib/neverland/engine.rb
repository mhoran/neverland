module Neverland
  class Engine < Rails::Engine
    initializer 'neverland.static_assets' do |app|
      app.middleware.insert_before('ActionDispatch::Static', 'ActionDispatch::Static', "#{root}/public")
    end
  end
end
