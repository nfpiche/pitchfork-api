defmodule PitchforkApi.AlbumTest do
  use PitchforkApi.ModelCase
  alias PitchforkApi.Album

  @valid_attrs %{name: "test", rating: 5.5}
  @invalid_attrs %{rating: "bad"}

  test "changeset with valid attributes" do
    changeset = Album.changeset(%Album{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Album.changeset(%Album{}, @invalid_attrs)
    refute changeset.valid?
  end
end
