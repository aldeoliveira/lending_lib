defmodule LendingLibWeb.BookControllerTest do
  use LendingLibWeb.ConnCase

  import LendingLib.CollectionFixtures

  @create_attrs %{title: "some title", publication_date: ~D[2024-02-04]}
  @update_attrs %{title: "some updated title", publication_date: ~D[2024-02-05]}
  @invalid_attrs %{title: nil, publication_date: nil}

  describe "index" do
    @tag :not_ready
    test "lists all books", %{conn: conn} do
      conn = get(conn, Routes.book_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Books"
    end
  end

  describe "new book" do
    @tag :not_ready
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.book_path(conn, :new))
      assert html_response(conn, 200) =~ "New Book"
    end
  end

  describe "create book" do
    @tag :not_ready
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.book_path(conn, :show, id)

      conn = get(conn, Routes.book_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Book"
    end

    @tag :not_ready
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Book"
    end
  end

  describe "edit book" do
    setup [:create_book]

    @tag :not_ready
    test "renders form for editing chosen book", %{conn: conn, book: book} do
      conn = get(conn, Routes.book_path(conn, :edit, book))
      assert html_response(conn, 200) =~ "Edit Book"
    end
  end

  describe "update book" do
    setup [:create_book]

    @tag :not_ready
    test "redirects when data is valid", %{conn: conn, book: book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @update_attrs)
      assert redirected_to(conn) == Routes.book_path(conn, :show, book)

      conn = get(conn, Routes.book_path(conn, :show, book))
      assert html_response(conn, 200) =~ "some updated title"
    end

    @tag :not_ready
    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Book"
    end
  end

  describe "delete book" do
    setup [:create_book]

    @tag :not_ready
    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, Routes.book_path(conn, :delete, book))
      assert redirected_to(conn) == Routes.book_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.book_path(conn, :show, book))
      end
    end
  end

  defp create_book(_) do
    book = book_fixture()
    %{book: book}
  end
end
