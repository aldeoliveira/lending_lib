defmodule LendingLib.CollectionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LendingLib.Collection` context.
  """

  @doc """
  Generate an author.
  """
  def author_fixture(attrs \\ %{}) do
    {:ok, author} =
      attrs
      |> Enum.into(%{
        name: "some name",
        date_of_birth: ~D[2024-02-04]
      })
      |> LendingLib.Collection.create_author()

    author
  end

  @doc """
  Generate a genre.
  """
  def genre_fixture(attrs \\ %{}) do
    {:ok, genre} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> LendingLib.Collection.create_genre()

    genre
  end

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        title: "some title",
        publication_date: ~D[2024-02-04]
      })
      |> LendingLib.Collection.create_book()

    book
  end
end
