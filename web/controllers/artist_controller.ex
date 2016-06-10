defmodule PitchforkApi.ArtistController do
  use PitchforkApi.Web, :controller
  alias PitchforkApi.Repo
  alias PitchforkApi.Artist

  whitelist_params = ~w(name avg)
  use Inquisitor, with: PitchforkApi.Artist, whitelist: whitelist_params

  def index(conn, params) do
    artists =
      build_artist_query(params)
      |> Repo.all()
      |> Repo.preload(:albums)

    {avg, _} =
      case params["avg"] do
        nil ->
          {0.0, :nothing}
        _ ->
          Float.parse(params["avg"])
      end

    render(conn, artists: artists, avg: avg)
  end

  def show(conn, %{"id" => id}) do
    artist =
      Artist
      |> Repo.get(id)
      |> Repo.preload(:albums)

    render conn, artist: artist
  end

  defp build_artist_query(query, [{"name", name}|tail]) do
    query
    |> Ecto.Query.where([a], ilike(a.name, ^"#{name}%"))
    |> build_artist_query(tail)
  end

  defp build_artist_query(_query, [{"avg", _}|tail]) do
    build_artist_query(tail)
  end
end
