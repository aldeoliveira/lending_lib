defmodule LendingLib.Accounts do
  alias LendingLib.Repo
  alias LendingLib.Accounts.Librarian

  def register_librarian(attrs) do
    %Librarian{}
    |> Librarian.registration_changeset(attrs)
    |> Repo.insert()
  end
end
