defmodule PitchforkApi.ArtistController do
  use PitchforkApi.Web, :controller
  alias PitchforkApi.Repo
  alias PitchforkApi.Artist

  whitelist_params = ~w(name avg limit)
  use Inquisitor, with: PitchforkApi.Artist, whitelist: whitelist_params

  def index(conn, params) do
    artists =
      build_artist_query(params)
      |> Repo.all()
      |> Repo.preload(:albums)

    avg = extract_avg params["avg"]

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

  defp build_artist_query(query, [{"limit", limit}|tail]) do
    query
    |> Ecto.Query.limit(^limit)
    |> build_artist_query(tail)
  end

  defp build_artist_query(_query, [{"avg", _}|tail]) do
    build_artist_query(tail)
  end

  defp extract_avg(params_avg) do
    {avg, _resp} =
      case params_avg do
        nil ->
          {0.0, :nothing}
        _ ->
          Float.parse(params_avg)
      end
    avg
  end
end
