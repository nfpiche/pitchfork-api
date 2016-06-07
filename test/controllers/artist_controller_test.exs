defmodule PitchforkApi.ArtistControllerTest do
  use ExUnit.Case, async: true
  use PitchforkApi.ConnCase
  alias PitchforkApi.Artist
  alias PitchforkApi.Repo

  @whitelist_params %{name: "artist1"}
  @invalid_params %{fake: "fake"}

  test "index lists all videos when no params passed in" do
    %Artist{name: "Artist1"} |> Repo.insert!
    %Artist{name: "Artist2"} |> Repo.insert!
    artists =
      Repo.all(Artist)
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
      |> Poison.encode!

    conn = get conn, artist_path(conn, :index, name: "Artist3")
    assert conn.status == 200
    assert conn.resp_body == "[#{artist}]"
  end

  test "show lists only video with matching id" do
    artist_object = %Artist{name: "Artist5"} |> Repo.insert!
    artist =
      Repo.get(Artist, artist_object.id)
      |> Poison.encode!

    conn = get conn, artist_path(conn, :show, artist_object.id)
    assert conn.status == 200
    assert conn.resp_body == artist
  end
end
