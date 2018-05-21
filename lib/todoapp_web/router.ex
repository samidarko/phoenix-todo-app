defmodule TodoappWeb.Router do
  use TodoappWeb, :router

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

  scope "/", TodoappWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/todos/:status", TodosController, :status
    post "/todos", TodosController, :create
    get "/todos/toggle/:id", TodosController, :toggle
    get "/todos/delete/:id", TodosController, :delete_confirmation
    post "/todos/delete/:id", TodosController, :delete
    get "/api/todos", ApiController, :index
  end

  # Other scopes may use custom stacks.
#   scope "/api", TodoappWeb do
#     pipe_through :api
#
#     get "/", ApiController, :index
#   end
end
