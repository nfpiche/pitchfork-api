defmodule PitchforkApi.AlbumView do
  use PitchforkApi.Web, :view

  def render("index.json", %{albums: albums}) do
    render_many(albums, PitchforkApi.AlbumView, "album.json")
  end

  def render("show.json", %{album: album}) do
    render_one(album, PitchforkApi.AlbumView, "album.json")
  end

  def render("album.json", %{album: album}) do
    album
  end
end
