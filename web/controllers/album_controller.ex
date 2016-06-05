defmodule PitchforkApi.AlbumController do
  use PitchforkApi.Web, :controller
  alias PitchforkApi.Repo
  alias PitchforkApi.Album

  whitelist_params = ~w(rating min_rating name artist)
  use Inquisitor, with: PitchforkApi.Album, whitelist: whitelist_params

  def index(conn, params) do
    albums =
      build_album_query(params)
      |> Album.get_albums
      |> Repo.all()

    render(conn, albums: albums)
  end

  def show(conn, %{"id" => id}) do
    album =
      Album
      |> Album.get_albums
      |> Repo.get(id)

    render(conn, album: album)
  end

  defp build_album_query(query, [{"min_rating", min_rating}|tail]) do
    query
    |> Ecto.Query.where([a], a.rating >= ^min_rating)
    |> build_album_query(tail)
  end

  defp build_album_query(query, [{"name", name}|tail]) do
    query
    |> Ecto.Query.where([a], ilike(a.name, ^"#{name}%"))
    |> build_album_query(tail)
  end

  defp build_album_query(query, [{"artist", artist}|tail]) do
    new_query =
      from a in query,
      join: ar in assoc(a, :artist),
      where: ilike(ar.name, ^"#{artist}%")

    new_query
    |> build_album_query(tail)
  end
end
