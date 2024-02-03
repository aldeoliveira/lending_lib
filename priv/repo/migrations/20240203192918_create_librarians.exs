defmodule LendingLib.Repo.Migrations.CreateLibrarians do
  use Ecto.Migration

  def change do
    create table(:librarians) do
      add :username, :string
      add :password_hash, :string
      add :email, :string

      timestamps()
    end
  end
end
