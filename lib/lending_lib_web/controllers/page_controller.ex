defmodule LendingLibWeb.PageController do
  use LendingLibWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
