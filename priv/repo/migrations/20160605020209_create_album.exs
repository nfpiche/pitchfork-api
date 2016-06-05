defmodule PitchforkApi.Repo.Migrations.CreateAlbum do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :rating, :float
      add :artist_id, references(:artists, on_delete: :nothing)

      timestamps
    end
    create index(:albums, [:artist_id])

  end
end
