defmodule LendingLibWeb.GenreController do
  use LendingLibWeb, :controller

  alias LendingLib.Collection
  alias LendingLib.Collection.Genre

  def index(conn, _params) do
    genres = Collection.list_genres()
    render(conn, "index.html", genres: genres)
  end

  def new(conn, _params) do
    changeset = Collection.change_genre(%Genre{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"genre" => genre_params}) do
    case Collection.create_genre(genre_params) do
      {:ok, genre} ->
        conn
        |> put_flash(:info, "Genre created successfully.")
        |> redirect(to: Routes.genre_path(conn, :show, genre))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    genre = Collection.get_genre!(id)
    render(conn, "show.html", genre: genre)
  end

  def edit(conn, %{"id" => id}) do
    genre = Collection.get_genre!(id)
    changeset = Collection.change_genre(genre)
    render(conn, "edit.html", genre: genre, changeset: changeset)
  end

  def update(conn, %{"id" => id, "genre" => genre_params}) do
    genre = Collection.get_genre!(id)

    case Collection.update_genre(genre, genre_params) do
      {:ok, genre} ->
        conn
        |> put_flash(:info, "Genre updated successfully.")
        |> redirect(to: Routes.genre_path(conn, :show, genre))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", genre: genre, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    genre = Collection.get_genre!(id)
    {:ok, _genre} = Collection.delete_genre(genre)

    conn
    |> put_flash(:info, "Genre deleted successfully.")
    |> redirect(to: Routes.genre_path(conn, :index))
  end
end
