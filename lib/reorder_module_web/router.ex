defmodule ReorderModuleWeb.Router do
  use ReorderModuleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReorderModuleWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/registrations", UserController, only: [:create, :new]
    resources "/orders", OrderController
    resources "/warehouses", WarehouseController
    resources "/products", ProductController do
        resources "/reorders", ReorderController
    end
    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReorderModuleWeb do
  #   pipe_through :api
  # end
end
