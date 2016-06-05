defmodule PitchforkApi.AlbumController do
  use PitchforkApi.Web, :controller
  alias PitchforkApi.Repo
  alias PitchforkApi.Album

  def index(conn, params) do
    albums =
      Album
      |> Album.build_query(params)
      |> Repo.all

    render(conn, albums: albums)
  end

  def show(conn, %{"id" => id}) do
    album =
      Album
      |> Album.get_albums
      |> Repo.get(id)

    render(conn, album: album)
  end
end
