defmodule LendingLib.Collection.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :publication_date, :date

    belongs_to :author, LendingLib.Collection.Author
    belongs_to :genre, LendingLib.Collection.Genre

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :publication_date, :author_id, :genre_id])
    |> validate_required([:title])
  end
end
