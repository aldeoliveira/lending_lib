defmodule LendingLib.Collection.Genre do
  use Ecto.Schema
  import Ecto.Changeset

  schema "genres" do
    field :name, :string

    timestamps()
  end

  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
