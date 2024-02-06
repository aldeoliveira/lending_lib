defmodule LendingLib.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string
      add :date_of_birth, :date

      timestamps()
    end
  end
end
