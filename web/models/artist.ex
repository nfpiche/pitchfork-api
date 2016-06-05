defmodule PitchforkApi.Artist do
  use PitchforkApi.Web, :model
  use Ecto.Model

  schema "artists" do
    field :name, :string
    has_many :albums, PitchforkApi.Album

    timestamps
  end

  @required_fields ~w(name)
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

  defimpl Poison.Encoder, for: PitchforkApi.Artist do
    def encode(artist, _options) do
      %{
        name: artist.name,
        id: artist.id
      } |> Poison.Encoder.encode([])
    end
  end
end
