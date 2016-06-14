defmodule PitchforkApi.ArtistView do
  alias PitchforkApi.Artist
  use PitchforkApi.Web, :view

  def render("index.json", %{artists: artists, avg: avg}) do
    Enum.map(artists, &(Map.put_new(&1, :average, Artist.average_rating(&1.albums))))
    |> Enum.filter(&(&1.average >= avg))
    |> render_many(PitchforkApi.ArtistView, "artist.json")
  end

  def render("show.json", %{artist: artist}) do
    Map.put_new(artist, :average, Artist.average_rating(artist))
    |> render_one(PitchforkApi.ArtistView, "artist.json")
  end

  def render("artist.json", %{artist: artist}) do
    %{
      id: artist.id,
      name: artist.name,
      average_album_rating: artist.average
    }
  end
end
