defmodule PitchforkApi.ArtistController do
  use PitchforkApi.Web, :controller
  alias PitchforkApi.Repo
  alias PitchforkApi.Artist

  whitelist_params = ~w(name)
  use Inquisitor, with: PitchforkApi.Artist, whitelist: whitelist_params

  def index(conn, params) do
    artists =
      build_artist_query(params)
      |> Repo.all()

    render(conn, artists: artists)
  end

  def show(conn, %{"id" => id}) do
    artist = Repo.get(Artist, id)
    render conn, artist: artist
  end

  defp build_artist_query(query, [{"name", name}|tail]) do
    query
    |> Ecto.Query.where([a], ilike(a.name, ^"#{name}%"))
    |> build_artist_query(tail)
  end
end
