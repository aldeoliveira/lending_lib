defmodule LendingLib.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :publication_date, :date
      add :author_id, references(:authors, on_delete: :nothing)
      add :genre_id, references(:genres, on_delete: :nothing)

      timestamps()
    end

    create index(:books, [:author_id])
    create index(:books, [:genre_id])
  end
end
