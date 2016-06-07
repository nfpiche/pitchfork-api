defmodule PitchforkApi.ArtistTest do
  use PitchforkApi.ModelCase
  alias PitchforkApi.Artist

  @valid_attrs %{name: "test"}
  @invalid_attrs %{name: 5}

  test "changeset with valid attributes" do
    changeset = Artist.changeset(%Artist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Artist.changeset(%Artist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
