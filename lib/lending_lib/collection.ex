defmodule LendingLib.Collection do
  @moduledoc """
  The Collection context.
  """

  import Ecto.Query, warn: false
  alias LendingLib.Repo

  alias LendingLib.Collection.Author
  alias LendingLib.Collection.Genre
  alias LendingLib.Collection.Book

  # Authors

  def list_authors do
    Author
    |> alphabetical(:name)
    |> Repo.all()
  end

  def get_author!(id), do: Repo.get!(Author, id)

  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  def change_author(%Author{} = author, attrs \\ %{}) do
    Author.changeset(author, attrs)
  end

  # Genres

  def list_genres do
    Genre
    |> alphabetical(:name)
    |> Repo.all()
  end

  def get_genre!(id), do: Repo.get!(Genre, id)

  def create_genre(attrs \\ %{}) do
    %Genre{}
    |> Genre.changeset(attrs)
    |> Repo.insert()
  end

  def update_genre(%Genre{} = genre, attrs) do
    genre
    |> Genre.changeset(attrs)
    |> Repo.update()
  end

  def delete_genre(%Genre{} = genre) do
    Repo.delete(genre)
  end

  def change_genre(%Genre{} = genre, attrs \\ %{}) do
    Genre.changeset(genre, attrs)
  end

  # Books

  def list_books do
    from(b in Book, preload: [:author, :genre])
    |> alphabetical(:title)
    |> Repo.all()
  end

  def get_book!(id) do
    Book
    |> Repo.get!(id)
    |> Repo.preload([:author, :genre])
  end

  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end

  defp alphabetical(query, ordering_attr) do
    from item in query, order_by: [^ordering_attr]
  end
end
