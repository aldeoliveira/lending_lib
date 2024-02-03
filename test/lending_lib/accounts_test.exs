defmodule LendingLib.AccountsTest do
  use LendingLib.DataCase

  alias LendingLib.Accounts

  describe "register_librarian/1" do
    test "register librarian with valid data" do
      {:ok, librarian} = Accounts.register_librarian(%{
        username: "hello_world",
        email: "hello@world.com",
        password_hash: "helloworld"
      })
      assert librarian.username == "hello_world"
      assert librarian.email == "hello@world.com"
      assert librarian.password_hash == "helloworld"
    end
  end
end
