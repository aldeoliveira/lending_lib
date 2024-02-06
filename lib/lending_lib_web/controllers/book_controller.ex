defmodule LendingLibWeb.BookController do
  use LendingLibWeb, :controller

  alias LendingLib.Collection
  alias LendingLib.Collection.Book

  plug :load_authors when action in [:new, :create, :edit, :update]
  plug :load_genres when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    books = Collection.list_books()
    render(conn, "index.html", books: books)
  end

  def new(conn, _params) do
    changeset = Collection.change_book(%Book{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"book" => book_params}) do
    case Collection.create_book(book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book created successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Collection.get_book!(id)
    render(conn, "show.html", book: book)
  end

  def edit(conn, %{"id" => id}) do
    book = Collection.get_book!(id)
    changeset = Collection.change_book(book)
    render(conn, "edit.html", book: book, changeset: changeset)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Collection.get_book!(id)

    case Collection.update_book(book, book_params) do
      {:ok, book} ->
        conn
        |> put_flash(:info, "Book updated successfully.")
        |> redirect(to: Routes.book_path(conn, :show, book))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", book: book, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Collection.get_book!(id)
    {:ok, _book} = Collection.delete_book(book)

    conn
    |> put_flash(:info, "Book deleted successfully.")
    |> redirect(to: Routes.book_path(conn, :index))
  end

  defp load_authors(conn, _) do
    assign(conn, :authors, Collection.list_authors())
  end

  defp load_genres(conn, _) do
    assign(conn, :genres, Collection.list_genres())
  end
end
