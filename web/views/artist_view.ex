defmodule PitchforkApi.ArtistView do
  use PitchforkApi.Web, :view

  def render("index.json", %{artists: artists}) do
    render_many(artists, PitchforkApi.ArtistView, "artist.json")
  end

  def render("show.json", %{artist: artist}) do
    render_one(artist, PitchforkApi.ArtistView, "artist.json")
  end

  def render("artist.json", %{artist: artist}) do
    %{
      id: artist.id,
      name: artist.name,
      average_album_rating: PitchforkApi.Artist.average_rating artist
    }
  end
end
