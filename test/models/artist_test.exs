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

  test "average_rating correctly averages list" do
    scores = [%{rating: 2.2}, %{rating: 5.5}, %{rating: 2.3232}, %{rating: 9.1}]
    average = Artist.average_rating(scores)
    assert average == 4.78
  end

  test "average_rating returns zero for empty list" do
    scores = []
    average = Artist.average_rating(scores)
    assert average == 0.0
  end
end
