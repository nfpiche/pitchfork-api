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

  def average_rating(artist) do
    average({0, 0, artist.albums})
    |> Float.round(2)
  end

  defp average({_, 0, []}) do
    0.0
  end

  defp average({total, count, []}) do
    total / count
  end

  defp average({total, count, [head | tail]}) do
    total = total + head.rating
    count = count + 1
    average({total, count, tail})
  end
end
