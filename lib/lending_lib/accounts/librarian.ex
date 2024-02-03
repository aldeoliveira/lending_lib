defmodule LendingLib.Accounts.Librarian do
  use Ecto.Schema
  import Ecto.Changeset

  schema "librarians" do
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(librarian, attrs) do
    librarian
    |> cast(attrs, [:username, :password_hash, :email])
    |> validate_required([:username, :password_hash, :email])
  end

  def registration_changeset(librarian, attrs) do
    librarian
    |> cast(attrs, [:email, :username, :password_hash])
  end
end
