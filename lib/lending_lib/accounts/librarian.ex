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

  def registration_changeset(librarian, attrs) do
    librarian
    |> cast(attrs, [:email, :username, :password])
    |> validate_email()
    |> validate_username()
    |> validate_password()
    |> put_pass_hash()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_length(:email, max: 50)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the 'example@example' format with no spaces")
    |> unique_constraint(:email)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_required([:username])
    |> validate_length(:username, min: 3, max: 50)
    |> unique_constraint(:username)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 50)
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ ->
        changeset
    end
  end
end
