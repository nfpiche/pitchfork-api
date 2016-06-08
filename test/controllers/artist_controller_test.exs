defmodule PitchforkApi.ArtistControllerTest do
  use ExUnit.Case, async: true
  use PitchforkApi.ConnCase
  alias PitchforkApi.Artist
  alias PitchforkApi.Repo
  alias PitchforkApi.ArtistView

  test "index lists all videos when no params passed in" do
    %Artist{name: "Artist1"} |> Repo.insert!
    %Artist{name: "Artist2"} |> Repo.insert!
    artists =
      Repo.all(Artist)
      |> Repo.preload(:albums)

    artists =
      ArtistView.render("index.json", %{artists: artists})
      |> Poison.encode!

    conn = get conn, artist_path(conn, :index)
    assert conn.status == 200
    assert conn.resp_body == artists
  end

  test "index lists only videos that meet params" do
    %Artist{name: "Artist3"} |> Repo.insert!
    %Artist{name: "Artist4"} |> Repo.insert!
    artist =
      Repo.get_by(Artist, name: "Artist3")
      |> Repo.preload(:albums)

    artist =
      ArtistView.render("show.json", %{artist: artist})
      |> Poison.encode!

    conn = get conn, artist_path(conn, :index, name: "Artist3")
    assert conn.status == 200
    assert conn.resp_body == "[#{artist}]"
  end

  test "show lists only video with matching id" do
    artist_object = %Artist{name: "Artist5"} |> Repo.insert!
    artist =
      Repo.get(Artist, artist_object.id)
      |> Repo.preload(:albums)

    artist =
      ArtistView.render("show.json", %{artist: artist})
      |> Poison.encode!

    conn = get conn, artist_path(conn, :show, artist_object.id)
    assert conn.status == 200
    assert conn.resp_body == artist
  end

  test "it doesn't apply filters that aren't whitelisted" do
    %Artist{name: "Artist6"} |> Repo.insert!
    %Artist{name: "Artist7"} |> Repo.insert!
    artists =
      Repo.all(Artist)
      |> Repo.preload(:albums)

    artists =
      ArtistView.render("index.json", %{artists: artists})
      |> Poison.encode!

    conn = get conn, artist_path(conn, :index, fake: "Artist7")
    assert conn.status == 200
    assert conn.resp_body == artists
  end

  test "it returns empty array if there are no artists" do
    %Artist{name: "Artist8"} |> Repo.insert!
    %Artist{name: "Artist9"} |> Repo.insert!

    conn = get conn, artist_path(conn, :index, name: "Where")
    assert conn.status == 200
    assert conn.resp_body == "[]"
  end
end
