defmodule LendingLibWeb.AuthorController do
  use LendingLibWeb, :controller

  alias LendingLib.Collection
  alias LendingLib.Collection.Author

  def index(conn, _params) do
    authors = Collection.list_authors()
    render(conn, "index.html", authors: authors)
  end

  def new(conn, _params) do
    changeset = Collection.change_author(%Author{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"author" => author_params}) do
    case Collection.create_author(author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "Author created successfully.")
        |> redirect(to: Routes.author_path(conn, :show, author))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Collection.get_author!(id)
    render(conn, "show.html", author: author)
  end

  def edit(conn, %{"id" => id}) do
    author = Collection.get_author!(id)
    changeset = Collection.change_author(author)
    render(conn, "edit.html", author: author, changeset: changeset)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Collection.get_author!(id)

    case Collection.update_author(author, author_params) do
      {:ok, author} ->
        conn
        |> put_flash(:info, "Author updated successfully.")
        |> redirect(to: Routes.author_path(conn, :show, author))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", author: author, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Collection.get_author!(id)
    {:ok, _author} = Collection.delete_author(author)

    conn
    |> put_flash(:info, "Author deleted successfully.")
    |> redirect(to: Routes.author_path(conn, :index))
  end
end
