defmodule PitchforkApi.Router do
  use PitchforkApi.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PitchforkApi do
    pipe_through :api

    resources "/artists", ArtistController, only: [:index, :show]
    resources "/albums", AlbumController, only: [:index, :show]
  end
end
