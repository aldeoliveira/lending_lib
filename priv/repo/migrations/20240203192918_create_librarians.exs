defmodule LendingLib.Repo.Migrations.CreateLibrarians do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:librarians) do
      add :username, :string
      add :password_hash, :string
      add :email, :citext

      timestamps()
    end

    create unique_index(:librarians, [:email])
    create unique_index(:librarians, [:username])
  end
end
