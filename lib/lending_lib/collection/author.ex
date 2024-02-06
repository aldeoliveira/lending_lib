defmodule LendingLib.Collection.Author do
  use Ecto.Schema
  import Ecto.Changeset

  schema "authors" do
    field :name, :string
    field :date_of_birth, :date

    timestamps()
  end

  @doc false
  def changeset(author, attrs) do
    author
    |> cast(attrs, [:name, :date_of_birth])
    |> validate_required([:name])
  end
end
