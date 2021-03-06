defmodule NflRushWeb.Router do
  use NflRushWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {NflRushWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NflRushWeb do
    pipe_through :browser

    get "/export", StatsController, :export

    live "/", PageLive, :index
  end
end
