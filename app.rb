class App < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_dir, "app/public"
    set :root, __dir__

    # Since Sinatra::AssetPack won't change the load path
    set :scss, { load_paths: [ "#{root}/app/assets/stylesheets" ] }
    puts "#{root}/app/assets/stylesheets" 

    set :sass, scss

    register Sinatra::AssetPack
  end

  assets do
    serve "/javascripts", from: "app/assets/javascripts"
    serve "/components",  from: "app/assets/components"
    serve "/stylesheets", from: "app/assets/stylesheets"
    serve "/images",      from: "app/assets/images"

    js :application, "/javascripts/application.js", [
      "/javascripts/script.js"
    ]

    css :application, "/stylesheets/application.css", [
      "/stylesheets/style.css"
    ]

    js_compression  :jsmin
    css_compression :sass
  end

  get "/" do
    erb :index
  end
end
