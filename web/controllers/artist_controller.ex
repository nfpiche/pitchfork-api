defmodule PitchforkApi.ArtistController do
  use PitchforkApi.Web, :controller
  alias PitchforkApi.Repo
  alias PitchforkApi.Artist

  def index(conn, _params) do
    artists = Repo.all(Artist)
    render(conn, artists: artists)
  end

  def show(conn, %{"id" => id}) do
    artist = Repo.get(Artist, id)
    render conn, artist: artist
  end
end
