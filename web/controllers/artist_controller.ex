defmodule PitchforkApi.ArtistController do
  use PitchforkApi.Web, :controller
  alias PitchforkApi.Repo
  alias PitchforkApi.Artist

  def index(conn, _params) do
    query = from a in Artist, preload: :albums
    artists_with_albums = Repo.all(query)
    render(conn, artists: artists_with_albums)
  end

  def show(conn, %{"id" => id}) do
    artist = Artist |> Repo.get(id) |> Repo.preload(:albums)
    render conn, artist: artist
  end
end
