defmodule PitchforkApi.Album do
  use PitchforkApi.Web, :model

  schema "albums" do
    field :name, :string
    field :rating, :float
    belongs_to :artist, PitchforkApi.Artist

    timestamps
  end

  @required_fields ~w(name rating)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def get_albums(query) do
    from a in query, preload: :artist
  end

  defimpl Poison.Encoder, for: PitchforkApi.Album do
    def encode(album, _options) do
      %{
        name: album.name,
        id: album.id,
        rating: album.rating,
        artist: album.artist.name
      } |> Poison.Encoder.encode([])
    end
  end
end
