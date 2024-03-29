defmodule LendingLibWeb.GenreControllerTest do
  use LendingLibWeb.ConnCase

  import LendingLib.CollectionFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    @tag :not_ready
    test "lists all genres", %{conn: conn} do
      conn = get(conn, Routes.genre_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Genres"
    end
  end

  describe "new genre" do
    @tag :not_ready
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.genre_path(conn, :new))
      assert html_response(conn, 200) =~ "New Genre"
    end
  end

  describe "create genre" do
    @tag :not_ready
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.genre_path(conn, :create), genre: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.genre_path(conn, :show, id)

      conn = get(conn, Routes.genre_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Genre"
    end

    @tag :not_ready
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.genre_path(conn, :create), genre: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Genre"
    end
  end

  describe "edit genre" do
    setup [:create_genre]

    @tag :not_ready
    test "renders form for editing chosen genre", %{conn: conn, genre: genre} do
      conn = get(conn, Routes.genre_path(conn, :edit, genre))
      assert html_response(conn, 200) =~ "Edit Genre"
    end
  end

  describe "update genre" do
    setup [:create_genre]

    @tag :not_ready
    test "redirects when data is valid", %{conn: conn, genre: genre} do
      conn = put(conn, Routes.genre_path(conn, :update, genre), genre: @update_attrs)
      assert redirected_to(conn) == Routes.genre_path(conn, :show, genre)

      conn = get(conn, Routes.genre_path(conn, :show, genre))
      assert html_response(conn, 200) =~ "some updated name"
    end

    @tag :not_ready
    test "renders errors when data is invalid", %{conn: conn, genre: genre} do
      conn = put(conn, Routes.genre_path(conn, :update, genre), genre: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Genre"
    end
  end

  describe "delete genre" do
    setup [:create_genre]

    @tag :not_ready
    test "deletes chosen genre", %{conn: conn, genre: genre} do
      conn = delete(conn, Routes.genre_path(conn, :delete, genre))
      assert redirected_to(conn) == Routes.genre_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.genre_path(conn, :show, genre))
      end
    end
  end

  defp create_genre(_) do
    genre = genre_fixture()
    %{genre: genre}
  end
end
