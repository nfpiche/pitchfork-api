defmodule PitchforkApi.TestHelpers do
  alias PitchforkApi.Repo

  def insert_artist(attrs) do
    %PitchforkApi.Artist{}
    |> PitchforkApi.Artist.changeset(attrs)
    |> Repo.insert!()
  end

  def insert_album(artist, attrs) do
    artist
    |> Ecto.build_assoc(:albums, attrs)
    |> Repo.insert!()
  end
end
