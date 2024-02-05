defmodule LendingLib.AccountsFixture do
  def valid_username, do: "hello_world"
  def valid_password, do: "helloworld"
  def valid_email, do: "hello@world.com"

  def valid_attributes() do
    %{
      username: valid_username(),
      email: valid_email(),
      password: valid_password()
    }
  end

  def librarian_fixture() do
    {:ok, librarian} =
      LendingLib.Accounts.register_librarian(valid_attributes())
    librarian
  end
end
