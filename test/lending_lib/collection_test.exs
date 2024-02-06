defmodule LendingLib.CollectionTest do
  use LendingLib.DataCase
  alias LendingLib.Collection
  alias LendingLib.Repo

  describe "authors" do
    alias LendingLib.Collection.Author
    import LendingLib.CollectionFixtures

    @invalid_attrs %{name: nil, date_of_birth: nil}

    test "list_authors/0 returns all authors in alphabetical order" do
      for name <- ~w( Katherine Daniel John Albert ) do Repo.insert(%Author{name: name}) end

      assert [
        %Author{name: "Albert"},
        %Author{name: "Daniel"},
        %Author{name: "John"},
        %Author{name: "Katherine"},
      ] = Collection.list_authors()
    end

    @tag :not_ready
    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Collection.get_author!(author.id) == author
    end

    @tag :not_ready
    test "create_author/1 with valid data creates a author" do
      valid_attrs = %{name: "some name", date_of_birth: ~D[2024-02-04]}

      assert {:ok, %Author{} = author} = Collection.create_author(valid_attrs)
      assert author.name == "some name"
      assert author.date_of_birth == ~D[2024-02-04]
    end

    @tag :not_ready
    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Collection.create_author(@invalid_attrs)
    end

    @tag :not_ready
    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      update_attrs = %{name: "some updated name", date_of_birth: ~D[2024-02-05]}

      assert {:ok, %Author{} = author} = Collection.update_author(author, update_attrs)
      assert author.name == "some updated name"
      assert author.date_of_birth == ~D[2024-02-05]
    end

    @tag :not_ready
    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Collection.update_author(author, @invalid_attrs)
      assert author == Collection.get_author!(author.id)
    end

    @tag :not_ready
    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Collection.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Collection.get_author!(author.id) end
    end

    @tag :not_ready
    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Collection.change_author(author)
    end
  end

  describe "genres" do
    alias LendingLib.Collection.Genre
    import LendingLib.CollectionFixtures

    @invalid_attrs %{name: nil}

    @tag :not_ready
    test "list_genres/0 returns all genres" do
      genre = genre_fixture()
      assert Collection.list_genres() == [genre]
    end

    @tag :not_ready
    test "get_genre!/1 returns the genre with given id" do
      genre = genre_fixture()
      assert Collection.get_genre!(genre.id) == genre
    end

    @tag :not_ready
    test "create_genre/1 with valid data creates a genre" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Genre{} = genre} = Collection.create_genre(valid_attrs)
      assert genre.name == "some name"
    end

    @tag :not_ready
    test "create_genre/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Collection.create_genre(@invalid_attrs)
    end

    @tag :not_ready
    test "update_genre/2 with valid data updates the genre" do
      genre = genre_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Genre{} = genre} = Collection.update_genre(genre, update_attrs)
      assert genre.name == "some updated name"
    end

    @tag :not_ready
    test "update_genre/2 with invalid data returns error changeset" do
      genre = genre_fixture()
      assert {:error, %Ecto.Changeset{}} = Collection.update_genre(genre, @invalid_attrs)
      assert genre == Collection.get_genre!(genre.id)
    end

    @tag :not_ready
    test "delete_genre/1 deletes the genre" do
      genre = genre_fixture()
      assert {:ok, %Genre{}} = Collection.delete_genre(genre)
      assert_raise Ecto.NoResultsError, fn -> Collection.get_genre!(genre.id) end
    end

    @tag :not_ready
    test "change_genre/1 returns a genre changeset" do
      genre = genre_fixture()
      assert %Ecto.Changeset{} = Collection.change_genre(genre)
    end
  end

  describe "books" do
    alias LendingLib.Collection.Book
    import LendingLib.CollectionFixtures

    @invalid_attrs %{title: nil, publication_date: nil}

    @tag :not_ready
    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Collection.list_books() == [book]
    end

    @tag :not_ready
    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Collection.get_book!(book.id) == book
    end

    @tag :not_ready
    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{title: "some title", publication_date: ~D[2024-02-04]}

      assert {:ok, %Book{} = book} = Collection.create_book(valid_attrs)
      assert book.title == "some title"
      assert book.publication_date == ~D[2024-02-04]
    end

    @tag :not_ready
    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Collection.create_book(@invalid_attrs)
    end

    @tag :not_ready
    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{title: "some updated title", publication_date: ~D[2024-02-05]}

      assert {:ok, %Book{} = book} = Collection.update_book(book, update_attrs)
      assert book.title == "some updated title"
      assert book.publication_date == ~D[2024-02-05]
    end

    @tag :not_ready
    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Collection.update_book(book, @invalid_attrs)
      assert book == Collection.get_book!(book.id)
    end

    @tag :not_ready
    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Collection.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Collection.get_book!(book.id) end
    end

    @tag :not_ready
    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Collection.change_book(book)
    end
  end
end
