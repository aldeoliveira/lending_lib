defmodule LendingLib.AccountsTest do
  use LendingLib.DataCase

  alias LendingLib.Repo
  alias LendingLib.Accounts
  alias LendingLib.Accounts.Librarian

  import LendingLib.AccountsFixture

  describe "register_librarian/1" do
    test "register librarian with valid data" do
      {:ok, %Librarian{id: id}} = Accounts.register_librarian(%{
        username: "hello_world",
        email: "hello@world.com",
        password: "helloworld"
      })

      assert [%Librarian{
        id: ^id,
        username: "hello_world",
        email: "hello@world.com",
      }] = Repo.all(Librarian)
    end

    test "hashes password when registering librarian" do
      {:ok, %Librarian{password_hash: hashed_password}} =
        Accounts.register_librarian(valid_attributes())
      assert Pbkdf2.verify_pass(valid_password(), hashed_password)
    end

    test "requires email, username and password to be set" do
      {:error, changeset} = Accounts.register_librarian(%{})
      assert %{
        email: ["can't be blank"],
        username: ["can't be blank"],
        password: ["can't be blank"],
      } = errors_on(changeset)
    end

    test "requires email to have proper format" do
      {:error, changeset} = Accounts.register_librarian(%{
        valid_attributes() | email: "invalid format"
      })
      assert %{email: ["must have the 'example@example' format with no spaces"]} = errors_on(changeset)
    end

    test "validate minimum values for username and password" do
      {:error, changeset} = Accounts.register_librarian(%{
        email: valid_email(), username: "ab", password: "12345"
      })
      assert %{
        username: ["should be at least 3 character(s)"],
        password: ["should be at least 6 character(s)"]
      } = errors_on(changeset)
    end

    test "validate maximum values for email, username and password" do
      too_long_email = String.duplicate("db", 100) <> "@example.com"
      too_long = String.duplicate("db", 100)
      {:error, changeset} = Accounts.register_librarian(%{
        email: too_long_email, username: too_long, password: too_long
      })
      assert %{
        email: ["should be at most 50 character(s)"],
        username: ["should be at most 50 character(s)"],
        password: ["should be at most 50 character(s)"]
      } = errors_on(changeset)
    end

    test "validate email uniqueness" do
      email = "hello@world"
      username = "hello_world"
      password = "123456"
      assert {:ok, _} = Accounts.register_librarian(%{
        email: email,
        username: username,
        password: password
      })
      assert {:error, changeset} = Accounts.register_librarian(%{
        email: email,
        username: "hello_mars",
        password: password
      })
      assert "has already been taken" in errors_on(changeset).email

      # Check that email case is ignored.
      assert {:error, changeset} = Accounts.register_librarian(%{
        email: String.upcase(email),
        username: "hello_mars",
        password: password
      })
      assert "has already been taken" in errors_on(changeset).email
    end

    test "validate username uniqueness" do
      username = "hello_world"
      password = "123456"
      assert {:ok, _} = Accounts.register_librarian(%{
        email: "hello@world",
        username: username,
        password: password
      })
      assert {:error, changeset} = Accounts.register_librarian(%{
        email: "hello@mars",
        username: username,
        password: password
      })
      assert "has already been taken" in errors_on(changeset).username
    end
  end
end
